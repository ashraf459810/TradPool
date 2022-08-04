import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/home/domain/repository/create_support_request_repository.dart';

abstract class CreateSupportRequestUseCase {
  Future<Either<Failure,void> >createSupportRequestuseCase ( String userId , String supportID, String text);
}


class CreateSupportRequestUseCaseImp implements CreateSupportRequestUseCase{
  final CreateSupportRepository createSupportRepository ;

  CreateSupportRequestUseCaseImp(this.createSupportRepository);

  @override
  Future<Either<Failure, void>> createSupportRequestuseCase(String userId, String supportID, String text) async {
    return await createSupportRepository.createSupportRepository(userId, supportID, text);
  }
}