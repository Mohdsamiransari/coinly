import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coinly/core/common/model/request_status.dart';
import 'package:coinly/features/expense/data/model/add_expense_model.dart';
import 'package:coinly/features/expense/data/model/expense_category.model.dart';
import 'package:coinly/features/expense/data/model/expense_filter_model.dart';
import 'package:coinly/features/expense/data/model/expense_model.dart'
    as expense_model;
import 'package:coinly/features/expense/data/repositories/expense_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  List<String> expenseTypes = [];
  String selectedSortName = "newest";
  double amount = 0;

  ExpenseBloc() : super(const ExpenseState()) {
    on<GetRecentTransactionsEvent>(_getRecentTransactionsEvent);
    on<GetExpenseCategoryEvent>(_getExpenseCategoryEvent);
    on<SelectExpenseCategoryEvent>(_selectExpenseCategoryEvent);
    on<FilterExpenseDataEvent>(
      _filterExpenseDataEvent,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 500))
          .asyncExpand(mapper),
    );
    on<AddExpenseEvent>(_addExpenseEvent);
    on<ExpenseFilterEvent>(_expenseFilterEvent);
    on<ResetFilterEvent>(_resetFilterEvent);
  }

  FutureOr<void> _getRecentTransactionsEvent(
    GetRecentTransactionsEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    try {
      emit(state.copyWith(
        transactions: const RequestStatus.loading(),
      ));
      emit(state.copyWith(
        transactions: RequestStatus.success(data: expense_model.ExpenseModel()),
      ));

      final expenseData = await ExpenseRepository().expenses();

      if (expenseData == null ||
          expenseData.data == null ||
          expenseData.data!.isEmpty) {
        emit(state.copyWith(
          transactions: const RequestStatus.empty(),
        ));
        return;
      }

// context.read<HomeBloc>().add(GetTotalBalanceEvent());
      emit(state.copyWith(
        transactions: RequestStatus.success(data: expenseData),
      ));
    } catch (e) {
      log("Error getting recent transactions: $e");
      emit(state.copyWith(
        transactions: const RequestStatus.error("Failed to load transactions"),
      ));
    }
  }

  FutureOr<void> _getExpenseCategoryEvent(
    GetExpenseCategoryEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    try {
      emit(state.copyWith(
        expenseCategory: const RequestStatus.loading(),
      ));

      final expenseCategoryData =
          await ExpenseRepository().getExpenseCategory();

      if (expenseCategoryData == null ||
          expenseCategoryData.data == null ||
          expenseCategoryData.data!.isEmpty) {
        emit(state.copyWith(expenseCategory: const RequestStatus.empty()));
      }

      emit(state.copyWith(
        expenseCategory: RequestStatus.success(data: expenseCategoryData),
      ));
    } catch (e) {
      log("Error getting expense categories: $e");
      emit(state.copyWith(
        expenseCategory: const RequestStatus.error("Failed to load categories"),
      ));
    }
  }

  FutureOr<void> _selectExpenseCategoryEvent(
    SelectExpenseCategoryEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    try {
      emit(state.copyWith(
        selectedExpenseCategory: RequestStatus.success(data: event.categoryId),
      ));
    } catch (e) {
      log("Error selecting expense category: $e");
      emit(state.copyWith(
        selectedExpenseCategory:
            const RequestStatus.error("Failed to select category"),
      ));
    }
  }

  FutureOr<void> _filterExpenseDataEvent(
      FilterExpenseDataEvent event, Emitter<ExpenseState> emit) async {
    try {
      final allTransactions = state.transactions.data?.data ?? [];

      // Edge case: No transactions at all
      if (allTransactions.isEmpty) {
        emit(state.copyWith(
          filteredTransactions: const RequestStatus.success(data: []),
        ));
        return;
      }

      List<expense_model.Data> filteredData = allTransactions.where((expense) {
        final name = expense.expenseName?.toLowerCase() ?? '';
        final category = expense.expenseCategory?.name?.toLowerCase() ?? '';

        final matchNames = event.searchKeyword.isEmpty ||
            name.contains(event.searchKeyword.toLowerCase());
        final matchesType = expenseTypes.isEmpty ||
            expenseTypes.toString().toLowerCase().contains(category);

        final matchesAmount = amount == 0 || expense.expenseAmount! <= amount;

        return matchesType && matchesAmount && matchNames;
      }).toList();

      // Edge case: No match after filtering
      if (filteredData.isEmpty) {
        emit(state.copyWith(
          filteredTransactions: const RequestStatus.success(data: []),
        ));
        return;
      }
      // --- Apply sorting ---
      switch (selectedSortName) {
        case 'newest':
          filteredData.sort((a, b) => b.expenseDate!.compareTo(a.expenseDate!));
          break;
        case 'oldest':
          filteredData.sort((a, b) => a.expenseDate!.compareTo(b.expenseDate!));
          break;
        case 'highest price':
          filteredData
              .sort((a, b) => a.expenseAmount!.compareTo(b.expenseAmount!));
          break;
        case 'lowest price':
          filteredData
              .sort((a, b) => b.expenseAmount!.compareTo(a.expenseAmount!));
          break;
      }
      emit(state.copyWith(
          filteredTransactions: RequestStatus.success(data: filteredData)));
    } catch (e) {
      emit(state.copyWith(transactions: state.transactions));
    }
  }

  FutureOr<void> _addExpenseEvent(
      AddExpenseEvent event, Emitter<ExpenseState> emit) async {
    try {
      // Only emit loading if not already loading
      if (!state.addTransactionResponse.isLoading) {
        emit(state.copyWith(
            addTransactionResponse: const RequestStatus.loading()));
      }

      final response = await ExpenseRepository().addTransaction(event.data);
      log("New Expense Response $response");

      if (response?.data == null) {
        emit(state.copyWith(
            addTransactionResponse:
                const RequestStatus.error("Error Creating Expense")));
        return;
      }

      // Emit success state only once
      emit(state.copyWith(
          addTransactionResponse: RequestStatus.success(data: response)));
    } catch (e) {
      emit(state.copyWith(
          addTransactionResponse:
              const RequestStatus.error("Error Creating Expense")));
    }
  }

  FutureOr<void> _expenseFilterEvent(
    ExpenseFilterEvent event,
    Emitter<ExpenseState> emit,
  ) {
    try {
      emit(state.copyWith(expenseFilter: const RequestStatus.loading()));

      selectedSortName = event.sortName ?? selectedSortName;
      if (event.expenseType != null) {
        if (expenseTypes.contains(event.expenseType)) {
          expenseTypes.remove(event.expenseType);
        } else {
          expenseTypes.add(event.expenseType!);
        }
      }
      amount = event.amount ?? amount;
      final updatedData = ExpenseFilterModel(
        sortName: selectedSortName,
        expenseType: expenseTypes,
        amount: amount,
      );
      emit(state.copyWith(
        expenseFilter: RequestStatus.success(data: updatedData),
      ));
    } catch (e) {
      emit(state.copyWith(
        expenseFilter: const RequestStatus.error("Error Filtering"),
      ));
    }
  }

  FutureOr<void> _resetFilterEvent(
      ResetFilterEvent event, Emitter<ExpenseState> emit) {
    try {
      selectedSortName = "";
      expenseTypes.clear();
      amount = 0;
      add(FilterExpenseDataEvent(searchKeyword: ""));
      emit(state.copyWith(
        expenseFilter: RequestStatus.success(data: ExpenseFilterModel()),
      ));
    } catch (e) {
      emit(state.copyWith(
          filteredTransactions:
              const RequestStatus.error("Error reset filter")));
    }
  }
}
