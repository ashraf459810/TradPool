import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradpool/core/consts.dart';
import 'package:tradpool/features/splash/domain/usecases/save_token_use_case.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SaveTpkenUseCase saveTpkenUseCase;
  SplashBloc(this.saveTpkenUseCase) : super(SplashInitial()) {
    on<SplashEvent>((event, emit) async {
      if (event is SaveFcmTokenEvent) {
        final shared = await SharedPreferences.getInstance();
        var token = shared.getString(Con.token);
        log('here the token $token');
        if (token != null) {
          final fcmToken = shared.getString(Con.fcmToken);
          log('here fcm token $fcmToken');
          final result =
              await saveTpkenUseCase.saveTokenUseCase(token, fcmToken);
          result.fold((l) => log(l.error??""), (r) => log("done from save token "));
        }
      }
      if (event is NavigateEvent) {
        emit(NavigateState(event.id));
      }
    });
  }
}
