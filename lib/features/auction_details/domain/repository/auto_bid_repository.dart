import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';

abstract class AutoBidRepositorry {
  Future<Either<Failure, void>> autoBidRepo(
      String auctionId, String price, String userID);
}
