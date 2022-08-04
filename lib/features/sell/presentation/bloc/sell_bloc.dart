import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradpool/core/consts.dart';
import 'package:tradpool/features/sell/data/models/all_auctions_model.dart';
import 'package:tradpool/features/sell/domain/usecases/user_auctions_use_case.dart';

part 'sell_event.dart';
part 'sell_state.dart';

class SellBloc extends Bloc<SellEvent, SellState> {
  final UserAuctionsUseCase useCase;
  SellBloc(this.useCase) : super(SellInitial()) {
    on<SellEvent>((event, emit) async {
      if (event is UserAuctionsEvent) {
        emit(Loading());

        final shared = await SharedPreferences.getInstance();
        String token = shared.getString(Con.token);

        PagenationParams pagenationParams =
            PagenationParams(event.page, event.size, token);

        final response = await useCase.call(pagenationParams);

        response.fold((l) => emit(Error(l.error)),
            (r) => emit(UserAuctionsState(r.content)));
      }
    });
  }
}
