import 'package:dartz/dartz.dart';
import 'package:dio_refresh_bot/dio_refresh_bot.dart';
import '../../../../common/network/exception/failure.dart';
import '../../data/models/login_auth_model.dart';
import '../entities/login_auth_param.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginAuthModel>> loginAuth({
    required LoginAuthParam loginAuthParam,
  });

  void logout();

  Stream<AuthStatus> get authStatusStream;
}
