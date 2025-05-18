part of 'expense_bloc.dart';

@immutable
class ExpenseState extends Equatable {
  final RequestStatus<List<Transaction>> transactions;
  final RequestStatus addTransaction;
  final RequestStatus<List<Map<String, dynamic>>> getExpenseCategory;
  final RequestStatus<String> selectedExpenseCategory;

  const ExpenseState({
    this.transactions = const RequestStatus.idle(),
    this.addTransaction = const RequestStatus.idle(),
    this.getExpenseCategory = const RequestStatus.idle(),
    this.selectedExpenseCategory = const RequestStatus.idle(),
  });

  ExpenseState copyWith({
    RequestStatus<List<Transaction>>? transactions,
    RequestStatus? addTransaction,
    RequestStatus<List<Map<String, dynamic>>>? getExpenseCategory,
    RequestStatus<String>? selectedExpenseCategory,
  }) {
    return ExpenseState(
      transactions: transactions ?? this.transactions,
      addTransaction: addTransaction ?? this.addTransaction,
      getExpenseCategory: getExpenseCategory ?? this.getExpenseCategory,
      selectedExpenseCategory:
          selectedExpenseCategory ?? this.selectedExpenseCategory,
    );
  }

  @override
  List<Object?> get props => [transactions, addTransaction, getExpenseCategory, selectedExpenseCategory];
}
