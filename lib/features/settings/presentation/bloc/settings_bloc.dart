import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:tradpool/features/settings/data/model/preferences_body_model.dart';
import 'package:tradpool/features/settings/data/model/preferences_response_model.dart';
import 'package:tradpool/features/settings/data/model/update_user_model.dart';
import 'package:tradpool/features/settings/data/model/user_history_model.dart';
import 'package:tradpool/features/settings/data/model/user_info_response_model.dart';
import 'package:tradpool/features/settings/data/model/winned_auctions_model.dart';
import 'package:tradpool/features/settings/domain/usecase/fetch_user_preferences_use_case.dart';
import 'package:tradpool/features/settings/domain/usecase/fill_user_preferences_use_case.dart';
import 'package:tradpool/features/settings/domain/usecase/get_user_info_use_case.dart';
import 'package:tradpool/features/settings/domain/usecase/support_request_use_case.dart';
import 'package:tradpool/features/settings/domain/usecase/update_user_profile_use_case.dart';
import 'package:tradpool/features/settings/domain/usecase/user_history_use_case.dart';
import 'package:tradpool/features/settings/domain/usecase/winned_auctions_use_case.dart';
import 'package:tradpool/features/verfication/domain/usecases/user_info_use_case.dart';

import '../../data/model/support_request_model.dart';
import '../../data/model/support_user_request_model.dart';
import '../../data/model/user_preferences_model.dart';
import '../../domain/usecase/support_request_details_use_case.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final UpdateUserInfoUseCase updateUserInfoUseCase;
  final GetUserInfoUseCase getUserInfoUseCase;
  final FetchUserPreferencesUseCase fetchUserPreferencesUseCase;
  final SupportRequestDetailsUseCase supportRequestDetailsUseCase;
  final FillUserPreferencesUseCase userPreferencesUseCase;
  final SupportRequestUseCase supportRequestUseCase;
  final SaveToken saveToken;
  final UserHistoryUseCase userHistoryUseCase;
  final WinnedAuctionsUseCase winnedAuctionsUseCase;
  SettingsBloc(this.userPreferencesUseCase, this.saveToken, this.winnedAuctionsUseCase, this.supportRequestUseCase, this.supportRequestDetailsUseCase, this.userHistoryUseCase, this.fetchUserPreferencesUseCase, this.getUserInfoUseCase, this.updateUserInfoUseCase) : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) async {

      if (event is UpdateProfileEvent){
        emit (LoadingUpdateProfile());
        var response = await updateUserInfoUseCase.updateProfileUseCase(event.updateUserBody);
        response.fold((l) => emit(Error(l.error)), (r) => emit(UpdateProfileState(r)));
      }

      if (event is GetUserInfoEvent){
        emit (LoadingUserInfo());
                var token = await saveToken.verficationRepository.getToken();
        var response= await getUserInfoUseCase.userInfo(token);
        response.fold((l) => emit(Error(l.error)), (r) => emit(UserInfoState(r)));
      }

      if (event is FetchUserPreferencesEvent){
        emit(LoadingFetchUserPreferencesState());
           var token = await saveToken.verficationRepository.getToken();
        var response= await fetchUserPreferencesUseCase.fetchUserPreferencesUseCase(token);
        response.fold((l) => emit(Error(l.error)), (r) => emit(FetchUserPreferencesState(r)));
      }
      if (event is UserHistoryEvent){
        emit (LoadingUserHistoryState());
        var response = await userHistoryUseCase.userHistoryUseCase(event.auctionId, event.page, event.size);
        response.fold((l) => emit(Error(l.error)), (r) => emit(UserHistoryState(r)));
      }

          if (event is SupportRequestDetailsEvent){
        emit (LoadingSupportRequest());
        var token = await saveToken.verficationRepository.getToken();
        
 var response = await supportRequestDetailsUseCase.supportRequestDetailsUseCase(token, event.requestId);
          response.fold((l) => emit(Error(l.error)), (r) => emit(SupportRequestDetailsState(r)));
      }

    
      if (event is SupportRequestEvent){
        emit (LoadingSupportRequest());
        var token = await saveToken.verficationRepository.getToken();
        
 var response = await supportRequestUseCase.supportRequestUseCase(token, event.page, event.size);
          response.fold((l) => emit(Error(l.error)), (r) => emit(SupportRequestState(r)));
      }

        if (event is WinnedAuctionsEvent){
            var token = await saveToken.verficationRepository.getToken();
          emit(LoadingWinnedAuctionsState());
          var response = await winnedAuctionsUseCase.winnedAuctionsUseCase(token, event.page, event.size);
          response.fold((l) => emit(Error(l.error)), (r) => emit(WinnedAuctionsState(r)));
        }


      if (event is FillUserPreferencesEvent){
        emit (LoadingPreferences());
        var token = await saveToken.verficationRepository.getToken();
        var response= await userPreferencesUseCase.fillUserPreferencesUseCase(token, event.preferencesBodyRequestModel); 
        response.fold((l) => emit(Error(l.error)), (r) => emit(PreferencesState(r)));
      }
    });
  }
}
