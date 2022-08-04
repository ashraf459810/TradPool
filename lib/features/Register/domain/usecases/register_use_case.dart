import 'package:tradpool/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/usecases/params.dart';
import 'package:tradpool/Core/usecases/usecase.dart';

import 'package:tradpool/features/register/domain/repositories/register_repository.dart';

class RegisterUseCase implements UseCase<String, Params> {
  final RegisterRepository registerRepository;

  RegisterUseCase(this.registerRepository);
  @override
  Future<Either<Failure, String>> call(Params params) async {
    return await registerRepository.createUser(params.user);
  }
}
