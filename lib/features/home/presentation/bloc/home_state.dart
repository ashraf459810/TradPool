part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class Loading extends HomeState {}

class Error extends HomeState {
  final String error;

  const Error(this.error);
}

class GetAuctionsState extends HomeState {
  final List<HomeAuctions> auctions;

  const GetAuctionsState(this.auctions);
}

class GetHomePageState extends HomeState{
  final HomePageModel homePageModel;

 const GetHomePageState(this.homePageModel);

}

class LoadingSupportTypeState extends HomeState {
  
}
class SupportTypeState extends HomeState {
  final List<SupportTypeModel >supportTypeModel;

  const SupportTypeState(this.supportTypeModel);
}
class CreateSupportRequestState extends HomeState{}


class GetFAQState extends HomeState {
  final List< FaqModel> faqModel;

  const GetFAQState(this.faqModel);
}

class GetBoutiqeAuctionsState extends HomeState{
  final BoutiqeAuctionsResponseModel boutiqeAuctionsResponseModel;

  const GetBoutiqeAuctionsState(this.boutiqeAuctionsResponseModel);
}
