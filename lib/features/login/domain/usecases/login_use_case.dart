import 'package:tradpool/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import 'package:tradpool/Core/usecases/usecase.dart';

import 'package:tradpool/features/login/domain/repositories/login_repository.dart';

class LoginUseCase implements UseCase<String, String> {
  final LoginRepository loginRepository;

  LoginUseCase(this.loginRepository);
  @override
  Future<Either<Failure, String>> call(String mobile) async {
    return await loginRepository.login(mobile);
  }
}
