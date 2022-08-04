import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tradpool/features/buy/data/models/buy_model.dart';
import 'package:tradpool/features/buy/domain/usecases/paid_auctions_use_case.dart';
import 'package:tradpool/features/verfication/domain/usecases/user_info_use_case.dart';

part 'buy_event.dart';
part 'buy_state.dart';

class BuyBloc extends Bloc<BuyEvent, BuyState> {
final  PaidAuctionUseCase paidAuctionUseCase;
final GetToken getToken;
  BuyBloc(this.paidAuctionUseCase, this.getToken) : super(BuyInitial()) {
    on<BuyEvent>((event, emit) async {
     if (event is PaidAuctionsEvent){
       emit (Loading());
       var token = await getToken.verficationRepository.getToken();
       var response = await paidAuctionUseCase.getPaidAuction(token);
       response.fold((l) => emit(Error(l.error)), (r) => emit(PaidAuctionState(r)));
       
     }
    });
  }
}
