part of 'expense_bloc.dart';

@immutable
sealed class ExpenseEvent {}

final class GetRecentTransactionsEvent extends ExpenseEvent {}

final class AddTransactionEvent extends ExpenseEvent {
  final ExpenseModel transaction;
  AddTransactionEvent(this.transaction);
}

final class GetExpenseCategoryEvent extends ExpenseEvent {}

final class SelectExpenseCategoryEvent extends ExpenseEvent {
  final String category;
  SelectExpenseCategoryEvent({required this.category});
}

final class FilterExpenseDataEvent extends ExpenseEvent {
  final String searchKeyword;

  FilterExpenseDataEvent({required this.searchKeyword});
}
