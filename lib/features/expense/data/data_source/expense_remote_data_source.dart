import 'package:coinly/core/network/api_endpoints.dart';
import 'package:coinly/core/network/api_result.model.dart';
import 'package:coinly/core/network/network_service.dart';
import 'package:coinly/features/expense/data/model/add_expense_model.dart';
import 'package:coinly/features/expense/data/model/expense_category.model.dart';
import 'package:coinly/features/expense/data/model/expense_model.dart';

class ExpenseRemoteDataSource {
  Future<ApiResult<ExpenseModel>> expenseApi() async {
    final response = await NetworkService<ExpenseModel>().get(
      ApiEndpoints.transaction,
      withAuth: true,
      parse: (json) => ExpenseModel.fromJson(json),
    );
    return response;
  }

  Future<ApiResult<AddExpenseModel>> addTransaction(
      Map<String, dynamic> expenseData) async {
    final response = await NetworkService<AddExpenseModel>().post(
      ApiEndpoints.addTransaction,
      withAuth: true,
      data: expenseData,
      parse: (json) => AddExpenseModel.fromJson(json),
    );
    return response;
  }

  Future<ApiResult<ExpenseCategoryModel>> getExpenseCategory() async {
    final response = await NetworkService<ExpenseCategoryModel>().get(
      ApiEndpoints.expenseCategory,
      parse: (json) => ExpenseCategoryModel.fromJson(json),
    );
    return response;
  }
}
