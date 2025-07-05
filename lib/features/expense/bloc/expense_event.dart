part of 'expense_bloc.dart';

@immutable
sealed class ExpenseEvent {}

final class GetRecentTransactionsEvent extends ExpenseEvent {}

final class GetExpenseCategoryEvent extends ExpenseEvent {}

final class SelectExpenseCategoryEvent extends ExpenseEvent {
  final int categoryId;
  SelectExpenseCategoryEvent({required this.categoryId});
}

final class FilterExpenseDataEvent extends ExpenseEvent {
  final String searchKeyword;

  FilterExpenseDataEvent({required this.searchKeyword});
}

final class AddExpenseEvent extends ExpenseEvent {
  final Map<String, dynamic> data;

  AddExpenseEvent({required this.data});
}
