import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coinly/core/common/model/request_status.dart';
import 'package:coinly/features/expense/data/model/add_expense_model.dart';
import 'package:coinly/features/expense/data/model/expense_category.model.dart';
import 'package:coinly/features/expense/data/model/expense_model.dart'
    as expense_model;
import 'package:coinly/features/expense/data/repositories/expense_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
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
  }

  FutureOr<void> _getRecentTransactionsEvent(
    GetRecentTransactionsEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    try {
      emit(state.copyWith(
        transactions: RequestStatus.loading(),
      ));
      emit(state.copyWith(
        transactions: RequestStatus.success(data: expense_model.ExpenseModel()),
      ));

      final expenseData = await ExpenseRepository().expenses();

      if (expenseData!.data!.isEmpty) {
        emit(state.copyWith(
          transactions: RequestStatus.empty(),
        ));
        return;
      }

// context.read<HomeBloc>().add(GetTotalBalanceEvent());
      emit(state.copyWith(
        transactions: RequestStatus.success(data: expenseData),
      ));
      log("sdlfakjdklfjadsfads sdfsdfsd ${expenseData.data?.length}");
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
      // If search is empty, clear filtered state
      if (event.searchKeyword.trim().isEmpty) {
        emit(state.copyWith(filteredTransactions: const RequestStatus.idle()));
        return;
      }
      final expenseDatas = state.transactions.data?.data ?? [];
      final filteredExpenseData = expenseDatas
          .where((expense) => expense.expenseName!
              .toLowerCase()
              .contains(event.searchKeyword.toLowerCase()))
          .toList();
      if (filteredExpenseData.isEmpty) {
        emit(state.copyWith(filteredTransactions: const RequestStatus.empty()));
        return;
      }
      emit(state.copyWith(
          filteredTransactions:
              RequestStatus.success(data: filteredExpenseData)));
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
}
