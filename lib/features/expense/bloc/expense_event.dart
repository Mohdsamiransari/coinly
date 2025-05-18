part of 'expense_bloc.dart';

@immutable
sealed class ExpenseEvent {}

final class GetRecentTransactionsEvent extends ExpenseEvent {}

final class AddTransactionEvent extends ExpenseEvent {
  final Transaction transaction;
  AddTransactionEvent(this.transaction);
}

final class GetExpenseCategoryEvent extends ExpenseEvent {}

final class SelectExpenseCategoryEvent extends ExpenseEvent {
  final String category;
  SelectExpenseCategoryEvent({required this.category});
}
