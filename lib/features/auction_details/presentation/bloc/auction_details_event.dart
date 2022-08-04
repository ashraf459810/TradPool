part of 'auction_details_bloc.dart';

abstract class AuctionDetailsEvent extends Equatable {
  const AuctionDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetStepEvent extends AuctionDetailsEvent {
  final String auctionid;

  const GetStepEvent(this.auctionid);
}

class AddBidEvent extends AuctionDetailsEvent {
  final String amount;
  final String auctionId;

  const AddBidEvent(this.amount, this.auctionId);
}

class GetAuctionDetailsEvent extends AuctionDetailsEvent {
  final String auctionId;

  const GetAuctionDetailsEvent(this.auctionId);
}

class AutoBidEvent extends AuctionDetailsEvent {
  final String auctionId;
  final String price;

  const AutoBidEvent(this.auctionId, this.price);
}
class WithdrawEvent extends AuctionDetailsEvent {
  final String auctionid;

  const WithdrawEvent(this.auctionid);
}


class BuyNowEvent extends AuctionDetailsEvent {
  final String auctionId;

 const BuyNowEvent(this.auctionId);
}

class AddRateAndFeedBackEvent extends AuctionDetailsEvent {
  final String rate;
  final String feedBack;
  final String auctionId;
  final String type;

const  AddRateAndFeedBackEvent(this.rate, this.feedBack, this.auctionId, this.type);

}
class SendMessagesEvent extends AuctionDetailsEvent {
  final MessageRequestBody messageRequestBody;

 const SendMessagesEvent(this.messageRequestBody);
}