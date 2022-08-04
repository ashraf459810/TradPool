import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradpool/core/error/failures.dart';
import 'package:tradpool/Core/usecases/params.dart';
import 'package:tradpool/features/register/data/models/create_user.dart';

import 'package:tradpool/features/register/domain/usecases/register_use_case.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterUseCase registerUseCase;
  RegisterBloc(this.registerUseCase) : super(RegisterInitial()) {
    Either<Failure, String> response;
    on<RegisterEvent>((event, emit) async {
      if (event is ToRegisterEvent) {
        log('here from bloc event');
        emit(Loading());

        if (event.createUserModel.mobileNumbermodel == null ||
            event.createUserModel.addressmodel == null ||
            event.createUserModel.emailmodel == null ||
            event.createUserModel.descriptionmodel == null ||
            event.createUserModel.namemodel == null) {
          log('here from bloc');
          emit(const Error("please complete your info"));
        } else {
          response = await registerUseCase(Params(user: event.createUserModel));
          response.fold((l) => emit(Error(l.getError())),
              (r) => emit(RegisterResponse(r)));
        }
      }
    });
  }
}
