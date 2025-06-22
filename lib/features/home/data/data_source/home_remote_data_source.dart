import 'package:coinly/core/network/api_endpoints.dart';
import 'package:coinly/core/network/api_result.model.dart';
import 'package:coinly/core/network/network_service.dart';
import 'package:coinly/features/home/data/model/amount_card.model.dart';

class HomeRemoteDataSource {
  Future<ApiResult<AmountModel>> amountApi() async {
    final response = await NetworkService<AmountModel>().get(
      ApiEndpoints.userAmount,
      withAuth: true,
      parse: (json) => AmountModel.fromJson(json),
    );
    return response;
  }
}
