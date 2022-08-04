part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();  

  @override
  List<Object> get props => [];
}
class SettingsInitial extends SettingsState {}


class LoadingPreferences extends SettingsState {}

class Error extends SettingsState {
  final String error ;

 const Error(this.error);
}

class PreferencesState extends SettingsState {
  final List<PreferencesResponseModel> preferencesResponseModel;

 const PreferencesState(this.preferencesResponseModel);
}

class WinnedAuctionsState extends SettingsState {
  final WinnedAuctionsModel winnedAuctionsModel ;

 const WinnedAuctionsState(this.winnedAuctionsModel);
}

class LoadingWinnedAuctionsState extends SettingsState {

}

class SupportRequestState extends SettingsState{
  final SupportRequestModel supportRequestModel;

 const SupportRequestState(this.supportRequestModel);
}
class LoadingSupportRequest extends SettingsState{}


class SupportRequestDetailsState extends SettingsState {
final  SupportRequestDetailsModel supportRequestModel;

const  SupportRequestDetailsState(this.supportRequestModel);
}

class UserHistoryState extends SettingsState {
  final UserHistoryModel userHistoryModel;

  const UserHistoryState(this.userHistoryModel);
}

class LoadingUserHistoryState extends SettingsState{}


class LoadingFetchUserPreferencesState extends SettingsState{}

class FetchUserPreferencesState extends SettingsState{
  final List<UserPreferencesModel> userPreferencesModel;

const  FetchUserPreferencesState(this.userPreferencesModel);
}

class UserInfoState extends SettingsState {

  final UserInfoResponseModel userInfoResponseModel;

 const UserInfoState(this.userInfoResponseModel);

}
class LoadingUserInfo extends SettingsState {

}

class UpdateProfileState extends SettingsState {
 final String userInfoResponseModel;

  const UpdateProfileState(this.userInfoResponseModel);
}

class LoadingUpdateProfile extends SettingsState{
  
}