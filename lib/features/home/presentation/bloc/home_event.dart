part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetAuctionsEvent extends HomeEvent {
  final int page;
  final int size;

  const GetAuctionsEvent(this.page, this.size);
}

class GetHomePageEvent extends HomeEvent{}

class SupportTypeEvent extends HomeEvent {
  final String code;

 const SupportTypeEvent(this.code);
}

class CreateSupportRequestEvent extends HomeEvent{
  final String supportId;
  final String text;

 const CreateSupportRequestEvent(this.supportId, this.text);
}



class GetFAQEvent extends HomeEvent {}

class GetBoutiqueAuctionsEvent extends HomeEvent{
  final String boutiqe;

 const GetBoutiqueAuctionsEvent(this.boutiqe);
}
