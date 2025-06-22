import 'package:coinly/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:coinly/features/auth/data/model/auth.model.dart';
import 'package:coinly/features/auth/data/model/auth_register.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositories {
  Future<AuthModel?> logIn({required Map<String, dynamic> data}) async {
    final response = await AuthRemoteDataSource().signIn(data: data);
    if (response.success) {
      final preference = await SharedPreferences.getInstance();
      preference.setString("token", response.data?.authData?.accessToken ?? "");
      return response.data;
    }
    return null;
  }

  Future<AuthRegisterModel?> register(
      {required Map<String, dynamic> data}) async {
    final response = await AuthRemoteDataSource().signUp(data: data);
    if (response.success) {
      final preference = await SharedPreferences.getInstance();
      preference.setString("token", response.data?.data?.token ?? "");
      return response.data;
    }
    return null;
  }
}
