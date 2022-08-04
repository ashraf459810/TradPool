import 'package:dartz/dartz.dart';
import 'package:tradpool/core/error/failures.dart';
import 'package:tradpool/features/auction_details/domain/repository/get_step_repository.dart';

abstract class GetStepUseCase {
  Future<Either<Failure, dynamic>> getStep(String auctionId);
}

class GetStepUseCaseImp implements GetStepUseCase {
  final GetStepRepository getStepRepository;

  GetStepUseCaseImp(this.getStepRepository);
  @override
  Future<Either<Failure, dynamic>> getStep(String auctionId) async {
    return await getStepRepository.getStep(auctionId);
  }
}
