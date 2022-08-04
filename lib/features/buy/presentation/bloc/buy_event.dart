part of 'buy_bloc.dart';

abstract class BuyEvent extends Equatable {
  const BuyEvent();

  @override
  List<Object> get props => [];
}

class PaidAuctionsEvent extends BuyEvent{
  
}