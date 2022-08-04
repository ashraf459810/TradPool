import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradpool/core/consts.dart';

import 'package:tradpool/core/error/failures.dart';
import 'package:tradpool/features/splash/domain/usecases/save_token_use_case.dart';
import 'package:tradpool/features/verfication/data/models/verfication_model.dart';
import 'package:tradpool/features/verfication/domain/usecases/user_info_use_case.dart';
import 'package:tradpool/features/verfication/domain/usecases/verfication_use_case.dart';

import '../../../../injection_container.dart';

part 'verfication_event.dart';
part 'verfication_state.dart';

class VerficationBloc extends Bloc<VerficationEvent, VerficationState> {
  final VerficationUseCase verficationUseCase;
  final SaveToken saveToken;

  final SetIsVerify setIsVerify;
  final SaveTpkenUseCase saveTpkenUseCase;
  Either<Failure, VerificationResponse> response;
  VerficationBloc(this.verficationUseCase, this.saveToken, this.setIsVerify,
      this.saveTpkenUseCase)
      : super(VerficationInitial()) {
    on<VerficationEvent>((event, emit) async {
      var fcmToken = await SharedPreferences.getInstance()
          .then((value) => value.getString(Con.fcmToken));
      if (event is ToVerfiyevent) {
        emit(Loading());
        if (event.code == null) {
          emit(const Error("please add your code"));
        } else {
          response = await verficationUseCase
              .call(MobileAndCode(code: event.code, mobile: event.mobile));

          response.fold((l) => emit(Error(l.toString())), (r) {
            if (r != null) {
              saveToken.call(r.id);
              sl<SharedPreferences>().setString("Auth", r.tk);
              setIsVerify.call(true);
              saveTpkenUseCase.saveTokenUseCase(r.id, fcmToken);
              emit(VerfiyResponse(r));
            } else {
              emit(const Error(
                  "Code not correct, please try to request a new one."));
            }
          });
        }
      }
    });
  }
}
