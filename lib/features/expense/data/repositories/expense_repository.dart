import 'package:coinly/features/expense/data/data_source/expense_remote_data_source.dart';
import 'package:coinly/features/expense/data/model/add_expense_model.dart';
import 'package:coinly/features/expense/data/model/expense_category.model.dart';
import 'package:coinly/features/expense/data/model/expense_model.dart';

class ExpenseRepository {
  Future<ExpenseModel?> expenses() async {
    final response = await ExpenseRemoteDataSource().expenseApi();
    return response.data;
  }

  Future<AddExpenseModel?> addTransaction(
      Map<String, dynamic> expenseData) async {
    final response =
        await ExpenseRemoteDataSource().addTransaction(expenseData);
    return response.data;
  }

  Future<ExpenseCategoryModel?> getExpenseCategory() async {
    final response = await ExpenseRemoteDataSource().getExpenseCategory();
    return response.data;
  }
}
