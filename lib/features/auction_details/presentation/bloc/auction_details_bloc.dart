import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:tradpool/features/auction_details/data/model/add_bid_response.dart';
import 'package:tradpool/features/auction_details/data/model/auction_details.dart';

import 'package:tradpool/features/auction_details/data/model/messages_request_body.dart';
import 'package:tradpool/features/auction_details/domain/use_case/add_bid_use_case.dart';
import 'package:tradpool/features/auction_details/domain/use_case/auction_details_use_case.dart';
import 'package:tradpool/features/auction_details/domain/use_case/auto_bid_use_case.dart';
import 'package:tradpool/features/auction_details/domain/use_case/buy_now_use_case.dart';
import 'package:tradpool/features/auction_details/domain/use_case/get_step_use_case.dart';
import 'package:tradpool/features/auction_details/domain/use_case/rate_and_feedback_use_case.dart';
import 'package:tradpool/features/auction_details/domain/use_case/send_message_use_case.dart';
import 'package:tradpool/features/auction_details/domain/use_case/withdraw_use_case.dart';
import 'package:tradpool/features/verfication/domain/usecases/user_info_use_case.dart';

part 'auction_details_event.dart';
part 'auction_details_state.dart';

class AuctionDetailsBloc
    extends Bloc<AuctionDetailsEvent, AuctionDetailsState> {
      final SendMessageUseCase sendMessageUseCase;
      final RateAndFeedBackUseCase rateAndFeedBackUseCase;
     final BuyNowUseCase buyNowUseCase;
  final AutoBidUseCase autoBidUseCase;
  final GetStepUseCase getStepUseCase;
  final AddBidUseCase addBidUseCase;
  final AuctionDetailsUseCase auctionDetailsUseCase;
  final GetToken getToken;
  final WithdrawUseCase withdrawUseCase;
  AuctionDetailsBloc(this.getStepUseCase, this.addBidUseCase,
      this.auctionDetailsUseCase, this.autoBidUseCase, this.getToken, this.withdrawUseCase, this.buyNowUseCase, this.rateAndFeedBackUseCase, this.sendMessageUseCase)
      : super(AuctionDetailsInitial()) {
    on<AuctionDetailsEvent>((event, emit) async {

      if (event is SendMessagesEvent ){
        var response= await sendMessageUseCase.sendMessageUseCase(event.messageRequestBody);
        response.fold((l) => emit(Error(l.error)), (r) => emit(SendMessagesState(r)));
      }

      if (event is AddRateAndFeedBackEvent){
        emit(AddRateAndFeedBackLoading());
              var token = await getToken.verficationRepository.getToken();
        var response = await rateAndFeedBackUseCase.rateAndFeedBackUseCase(event.type, event.auctionId, event.rate, event.feedBack, token);
        response.fold((l) => emit(Error(l.error)), (r) => emit(AddRateAndFeedBackState(r)));
      }
      if (event is WithdrawEvent){

         emit(LoadingWithdrawState());
          var token = await getToken.verficationRepository.getToken();

        var response = await withdrawUseCase.withdrawUseCase(token, event.auctionid);
        response.fold((l) => emit(Error(l.error)), (r) => emit(WithdrawState(r)));
      }
      if (event is GetStepEvent) {
        emit(Loading());
        var result = await getStepUseCase.getStep(event.auctionid);
        result.fold((l) => emit(Error(l.error)), (r) => emit(GetStepState(r)));
      }

      if (event is AddBidEvent) {
        String token = await getToken.verficationRepository.getToken();
        emit(Loading());
        var result = await addBidUseCase.addBid(
            event.auctionId, int.parse(event.amount), token);
        result.fold((l) => emit(Error(l.error)), (r) => emit(AddBidState(r)));
      }
      if (event is GetAuctionDetailsEvent) {
      
        emit(Loading());
        var token = await getToken.verficationRepository.getToken();
        var result = await auctionDetailsUseCase
            .getAuctionDetailsUseCase(event.auctionId,token);
        result.fold(
            (l) => emit(Error(l.error)), (r) => emit(GetAuctionState(r)));
      }
      if (event is AutoBidEvent) {
      
        String token = await getToken.verficationRepository.getToken();
        log(event.auctionId);
        log(token);
        var response = await autoBidUseCase.autoBidUseCase(
            event.auctionId, event.price, token);
        response.fold((l) => emit(Error(l.error)), (r) => emit(AutoBidState()));
      }

      if (event is BuyNowEvent) {
      emit(LoadingBuyNowState ());
        String token = await getToken.verficationRepository.getToken();
       
        var response = await buyNowUseCase.buyNowUseCase(
        token,   event.auctionId);
        response.fold((l) => emit(Error(l.error)), (r) => emit(BuyNowState(r)));
      }

      
    });
  }
}
