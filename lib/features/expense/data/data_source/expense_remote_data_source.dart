import 'package:coinly/core/network/api_endpoints.dart';
import 'package:coinly/core/network/api_result.model.dart';
import 'package:coinly/core/network/network_service.dart';
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
}