part of 'like_bloc.dart';

abstract class LikeEvent extends Equatable {
  const LikeEvent();

  @override
  List<Object> get props => [];
}


class AddToFavouriteEvent extends LikeEvent {
  final String auctionId;
  final String likeOrUnlike;

 const AddToFavouriteEvent(this.auctionId, this.likeOrUnlike);
}

class FetchUserFavouriteEvent extends LikeEvent{
  

 
  
}
