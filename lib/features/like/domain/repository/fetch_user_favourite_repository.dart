import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/home/data/model/favourite_model.dart';

abstract class FetchUserFavouriteRepository{

Future <Either<Failure,FavouritesModel>>  fetchUserRepository (String userId);
}