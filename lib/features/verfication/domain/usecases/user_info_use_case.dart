import 'package:tradpool/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/usecases/usecase.dart';
import 'package:tradpool/features/verfication/domain/repositories/verfication_repository.dart';

class SaveToken implements UseCase<void, String> {
  final VerficationRepository verficationRepository;

  SaveToken(this.verficationRepository);
  @override
  Future<Either<Failure, void>> call(String params) async {
    await verficationRepository.setToken(params);
    return null;
  }
}

class GetToken implements UseCase<String, dynamic> {
  final VerficationRepository verficationRepository;

  GetToken(this.verficationRepository);
  @override
  Future<Either<Failure, String>> call(dynamic) async {
    String token = await verficationRepository.getToken();
    return right(token);
  }
}

class GetIsVerify implements UseCase<bool, void> {
  final VerficationRepository verficationRepository;

  GetIsVerify(this.verficationRepository);
  @override
  Future<Either<Failure, bool>> call(dynamic) async {
    await verficationRepository.getIsVerify();
    return null;
  }
}

class SetIsVerify implements UseCase<bool, bool> {
  final VerficationRepository verficationRepository;

  SetIsVerify(this.verficationRepository);
  @override
  Future<Either<Failure, bool>> call(parm) async {
    await verficationRepository.setIsVerify(parm);
    return null;
  }
}
