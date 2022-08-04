import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/auction_details/data/model/auction_details.dart';
import 'package:tradpool/features/auction_details/domain/repository/add_rate_and_feedback_repository.dart';

abstract class RateAndFeedBackUseCase {

  Future<Either<Failure,AuctionDetailsModel>> rateAndFeedBackUseCase (String type , String auctionId, String rate , String feedback, String userId);
}

class RateAndFeedBackUseCaseImp implements RateAndFeedBackUseCase {
  final RateAndFeedBackRepository rateAndFeedBackRepository;

  RateAndFeedBackUseCaseImp(this.rateAndFeedBackRepository);

  @override
  Future<Either<Failure, AuctionDetailsModel>> rateAndFeedBackUseCase(String type, String auctionId, String rate, String feedback, String userId) async {
    return await rateAndFeedBackRepository.rateAndFeedBack(type, auctionId, rate, feedback, userId);
  }
}