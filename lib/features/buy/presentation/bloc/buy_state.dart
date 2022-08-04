part of 'buy_bloc.dart';

abstract class BuyState extends Equatable {
  const BuyState();  

  @override
  List<Object> get props => [];
}
class BuyInitial extends BuyState {}



class Loading extends BuyState {
  
}

class Error extends BuyState{
  final String error ;

  const Error(this.error);
}

class PaidAuctionState extends BuyState {
  final List<BuyAuctionModel> buyAuctionModel;

  const PaidAuctionState(this.buyAuctionModel);
}