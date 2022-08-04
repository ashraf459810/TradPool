import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';

abstract class AddToFavouriteRepository {
  Future <Either<Failure ,void >> addToFavourite (String auctionId , String userId,String likeOrUnlike);
}
