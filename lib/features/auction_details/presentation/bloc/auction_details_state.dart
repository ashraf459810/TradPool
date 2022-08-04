part of 'auction_details_bloc.dart';

abstract class AuctionDetailsState extends Equatable {
  const AuctionDetailsState();

  @override
  List<Object> get props => [];
}

class AuctionDetailsInitial extends AuctionDetailsState {}

class Loading extends AuctionDetailsState {}

class Error extends AuctionDetailsState {
  final String error;

  const Error(this.error);
}

class GetStepState extends AuctionDetailsState {
  final dynamic step;

   const GetStepState(this.step);
}

class AddBidState extends AuctionDetailsState {
  final AddBidResponse addBidResponse;

  const AddBidState(this.addBidResponse);
}

class GetAuctionState extends AuctionDetailsState {
  final AuctionDetailsModel auctionDetails;

  const GetAuctionState(this.auctionDetails);
}



class AutoBidState extends AuctionDetailsState {}


class WithdrawState extends AuctionDetailsState{
  final AuctionDetailsModel auctionDetailsModel;
  const WithdrawState(this.auctionDetailsModel);
}

class BuyNowState extends AuctionDetailsState {
  final AuctionDetailsModel auctionDetailsModel;

  const BuyNowState(this.auctionDetailsModel);

}

class LoadingBuyNowState extends AuctionDetailsState {}


class LoadingWithdrawState extends AuctionDetailsState{}

class AddRateAndFeedBackLoading extends AuctionDetailsState{}


class AddRateAndFeedBackState extends AuctionDetailsState{
  final AuctionDetailsModel auctionDetailsModel;

  const AddRateAndFeedBackState(this.auctionDetailsModel);


}

class SendMessagesState extends AuctionDetailsState {
  final List< Message> messagesModel;

 const SendMessagesState(this.messagesModel);
}