part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}


class FillUserPreferencesEvent extends SettingsEvent {
  final List<PreferencesBodyRequestModel >preferencesBodyRequestModel;

 const FillUserPreferencesEvent(this.preferencesBodyRequestModel);
}

class WinnedAuctionsEvent extends SettingsEvent {
  final String page;
  final String size;

  const WinnedAuctionsEvent(this.page, this.size);
  
}

class SupportRequestEvent extends SettingsEvent {
  final String page ;
  final String size;

const  SupportRequestEvent(this.page, this.size);
}

class SupportRequestDetailsEvent  extends SettingsEvent{
  final String requestId;

 const SupportRequestDetailsEvent(this.requestId);
}
class UserHistoryEvent extends SettingsEvent{
  final String auctionId;
  final String page;
  final String size;

 const UserHistoryEvent(this.auctionId, this.page, this.size);
}

class FetchUserPreferencesEvent extends SettingsEvent{
  
}


class GetUserInfoEvent extends SettingsEvent {

}

class UpdateProfileEvent extends SettingsEvent {
  final UpdateUserBody updateUserBody;

  const UpdateProfileEvent(this.updateUserBody);
}