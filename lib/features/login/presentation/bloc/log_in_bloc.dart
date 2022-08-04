import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tradpool/core/error/failures.dart';
import 'package:tradpool/features/login/domain/usecases/login_use_case.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  final LoginUseCase loginUseCase;
  LogInBloc(this.loginUseCase) : super(LogInInitial()) {
    Either<Failure, String> loginresponse;
    on<LogInEvent>((event, emit) async {
      if (event is ToLoginEvent) {
        emit(Loading());
        if (event.mobileNumber == null) {
          emit(const Error("please add your mobile number"));
        } else {
          loginresponse = await loginUseCase(event.mobileNumber);
          loginresponse.fold(
              (l) => emit(Error(l.getError())), (r) => emit(LoginResponse(r)));
        }
      }
    });
  }
}
