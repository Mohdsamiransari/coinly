import 'package:coinly/features/expense/data/data_source/expense_remote_data_source.dart';
import 'package:coinly/features/expense/data/model/expense_model.dart';

class ExpenseRepository {
   Future<ExpenseModel?> expenses() async {
    final response = await ExpenseRemoteDataSource().expenseApi();
    return response.data;
  }
}