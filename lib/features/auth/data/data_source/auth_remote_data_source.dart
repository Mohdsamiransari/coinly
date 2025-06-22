import 'package:coinly/core/network/api_endpoints.dart';
import 'package:coinly/core/network/api_result.model.dart';
import 'package:coinly/core/network/network_service.dart';
import 'package:coinly/features/auth/data/model/auth.model.dart';
import 'package:coinly/features/auth/data/model/auth_register.model.dart';

class AuthRemoteDataSource {
  Future<ApiResult<AuthModel>> signIn(
      {required Map<String, dynamic> data}) async {
    final response = await NetworkService<AuthModel>().post(
      ApiEndpoints.signIn,
      withAuth: false,
      data: data,
      parse: (json) => AuthModel.fromJson(json),
    );
    return response;
  }

  Future<ApiResult<AuthRegisterModel>> signUp(
      {required Map<String, dynamic> data}) async {
    final response = await NetworkService<AuthRegisterModel>().post(
      ApiEndpoints.signUp,
      parse: (json) => AuthRegisterModel.fromJson(json),
      data: data,
      withAuth: false,
    );
    return response;
  }
}
