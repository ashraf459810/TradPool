part of 'sell_bloc.dart';

abstract class SellState extends Equatable {
  const SellState();

  @override
  List<Object> get props => [];
}

class SellInitial extends SellState {}

class Loading extends SellState {}

class Error extends SellState {
  final String error;

  const Error(this.error);
}

class UserAuctionsState extends SellState {
  final List<UserAuctions> userAuctions;

  const UserAuctionsState(this.userAuctions);
}
