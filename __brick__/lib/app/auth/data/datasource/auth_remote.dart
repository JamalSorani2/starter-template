import 'package:dio/dio.dart';
import '../../../url.dart';
import '../../../../common/network/exception/error_handler.dart';
import '../models/login_auth_model.dart';
import '../../domain/entities/login_auth_param.dart';

class AuthRemote {
  final Dio _dio;
  const AuthRemote(Dio dio) : _dio = dio;
  Future<LoginAuthModel> loginAuth({
    required LoginAuthParam loginAuthParam,
  }) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.loginAuth,
        data: loginAuthParam.toJson(),
      );
      return LoginAuthModel.fromJson(response.data);
    });
  }
}
