import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coinly/core/common/model/request_status.dart';
import 'package:coinly/features/expense/data/model/expense_model.dart';
import 'package:coinly/features/expense/data/repositories/expense_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc() : super(const ExpenseState()) {
    on<GetRecentTransactionsEvent>(_getRecentTransactionsEvent);
    on<AddTransactionEvent>(_addTransactionEvent);
    on<GetExpenseCategoryEvent>(_getExpenseCategoryEvent);
    on<SelectExpenseCategoryEvent>(_selectExpenseCategoryEvent);
    on<FilterExpenseDataEvent>(
      _filterExpenseDataEvent,
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 500)).asyncExpand(mapper),
    );
  }

  FutureOr<void> _getRecentTransactionsEvent(
    GetRecentTransactionsEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    try {
      emit(state.copyWith(
        transactions: const RequestStatus.loading(),
      ));

      final expenseData = await ExpenseRepository().expenses();

      if (expenseData == null &&
          expenseData?.data == null &&
          expenseData!.data!.isEmpty) {
        emit(state.copyWith(
          transactions: const RequestStatus.empty(),
        ));
        return;
      }

      log("Recent Transaction $expenseData");

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

  FutureOr<void> _addTransactionEvent(
    AddTransactionEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    try {
      emit(state.copyWith(
        addTransaction: const RequestStatus.loading(),
      ));
      await Future.delayed(const Duration(seconds: 1));
      // state.transactions.data?.add(event.transaction);

      emit(state.copyWith(
        addTransaction: const RequestStatus.success(),
      ));
    } catch (e) {
      log("Error adding transaction: $e");
      emit(state.copyWith(
        addTransaction: const RequestStatus.error("Failed to add transaction"),
      ));
    }
  }

  FutureOr<void> _getExpenseCategoryEvent(
    GetExpenseCategoryEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    try {
      emit(state.copyWith(
        getExpenseCategory: const RequestStatus.loading(),
      ));
      await Future.delayed(const Duration(seconds: 2));

      final List<Map<String, dynamic>> categories = [
        {"name": "Electricity", "icon": "assets/images/expenseicon1.png"},
        {"name": "Groceries", "icon": "assets/images/expenseicon2.png"},
        {"name": "Food", "icon": "assets/images/expenseicon3.png"},
      ];

      emit(state.copyWith(
        getExpenseCategory: RequestStatus.success(data: categories),
      ));
    } catch (e) {
      log("Error getting expense categories: $e");
      emit(state.copyWith(
        getExpenseCategory:
            const RequestStatus.error("Failed to load categories"),
      ));
    }
  }

  FutureOr<void> _selectExpenseCategoryEvent(
    SelectExpenseCategoryEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    try {
      emit(state.copyWith(
        selectedExpenseCategory: RequestStatus.success(data: event.category),
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
}
