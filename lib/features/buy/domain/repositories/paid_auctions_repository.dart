import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/buy/data/models/buy_model.dart';

abstract class PaidAuctionsRepository {
  Future <Either <Failure , List<BuyAuctionModel >>> getPaidAuctions(String userId);
}