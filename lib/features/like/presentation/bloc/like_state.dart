part of 'like_bloc.dart';

abstract class LikeState extends Equatable {
  const LikeState();  

  @override
  List<Object> get props => [];
}
class LikeInitial extends LikeState {}




class Loading extends LikeState {}


class Error extends LikeState{
  final String error;

 const Error(this.error);

}
class AddToFavouriteState extends LikeState {

}

class FetchUserFavouriteState extends LikeState {

 final FavouritesModel favouritesModel ;

  const FetchUserFavouriteState(this.favouritesModel);


}
