
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/home/data/model/favourite_model.dart';
import 'package:tradpool/features/like/domain/repository/fetch_user_favourite_repository.dart';

abstract class FetchUserFavouriteUseCase {
  Future <Either< Failure , FavouritesModel>> fetchUserFavouriteUseCase (  String userId);
}





class FetchUserFavouriteUseCaseImp implements FetchUserFavouriteUseCase{
  final FetchUserFavouriteRepository fetchUserFavouriteRepository;

  FetchUserFavouriteUseCaseImp(this.fetchUserFavouriteRepository);

  @override
  Future<Either<Failure, FavouritesModel>> fetchUserFavouriteUseCase( String userId) async {
    return await fetchUserFavouriteRepository.fetchUserRepository(userId);
  }

  

  
}