part of 'expense_bloc.dart';

@immutable
class ExpenseState extends Equatable {
  final RequestStatus<expense_model.ExpenseModel> transactions;
  final RequestStatus<List<expense_model.Data>> filteredTransactions;
  final RequestStatus<int> selectedExpenseCategory;
  final RequestStatus<AddExpenseModel> addTransactionResponse;
  final RequestStatus<ExpenseCategoryModel> expenseCategory;
  final RequestStatus<ExpenseFilterModel> expenseFilter;

  const ExpenseState({
    this.transactions = const RequestStatus.idle(),
    this.filteredTransactions = const RequestStatus.idle(),
    this.selectedExpenseCategory = const RequestStatus.idle(),
    this.addTransactionResponse = const RequestStatus.idle(),
    this.expenseCategory = const RequestStatus.idle(),
    this.expenseFilter = const RequestStatus.idle(),
  });

  ExpenseState copyWith({
    RequestStatus<expense_model.ExpenseModel>? transactions,
    RequestStatus<List<expense_model.Data>>? filteredTransactions,
    RequestStatus<int>? selectedExpenseCategory,
    RequestStatus<AddExpenseModel>? addTransactionResponse,
    RequestStatus<ExpenseCategoryModel>? expenseCategory,
    RequestStatus<ExpenseFilterModel>? expenseFilter,
  }) {
    return ExpenseState(
      transactions: transactions ?? this.transactions,
      filteredTransactions: filteredTransactions ?? this.filteredTransactions,
      selectedExpenseCategory:
          selectedExpenseCategory ?? this.selectedExpenseCategory,
      addTransactionResponse:
          addTransactionResponse ?? this.addTransactionResponse,
      expenseCategory: expenseCategory ?? this.expenseCategory,
      expenseFilter: expenseFilter ?? this.expenseFilter,
    );
  }

  @override
  List<Object?> get props => [
        transactions,
        selectedExpenseCategory,
        filteredTransactions,
        addTransactionResponse,
        expenseCategory,
        expenseFilter,
      ];
}
