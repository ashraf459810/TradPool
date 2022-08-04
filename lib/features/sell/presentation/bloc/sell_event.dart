part of 'sell_bloc.dart';

abstract class SellEvent extends Equatable {
  const SellEvent();

  @override
  List<Object> get props => [];
}

class UserAuctionsEvent extends SellEvent {
  final int page;
  final int size;

  const UserAuctionsEvent(this.page, this.size);
}
