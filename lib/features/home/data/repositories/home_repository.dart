import 'package:coinly/features/home/data/data_source/home_remote_data_source.dart';
import 'package:coinly/features/home/data/model/amount_card.model.dart';

class HomeRepository {
   Future<AmountModel?> amountData() async {
    final response = await HomeRemoteDataSource().amountApi();
    return response.data;
  }
}