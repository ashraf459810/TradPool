import 'dart:developer';


import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tradpool/Core/use_case/use_case.dart';
import 'package:tradpool/features/home/data/model/all_auctions_model.dart';
import 'package:tradpool/features/home/data/model/boutique_response_model.dart';
import 'package:tradpool/features/home/data/model/faq_model.dart';
import 'package:tradpool/features/home/data/model/home_page_model.dart';
import 'package:tradpool/features/home/data/model/support_type_model.dart';
import 'package:tradpool/features/home/domain/use_case/all_auctions_use_case.dart';
import 'package:tradpool/features/home/domain/use_case/create_support_request_use_case.dart';
import 'package:tradpool/features/home/domain/use_case/get_faq_use_case.dart';
import 'package:tradpool/features/home/domain/use_case/home_page_use_case.dart';
import 'package:tradpool/features/home/domain/use_case/support_type_use_case.dart';
import 'package:tradpool/features/verfication/domain/usecases/user_info_use_case.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc  extends Bloc<HomeEvent, HomeState> {
  final CreateSupportRequestUseCase createSupportRequestUseCase;
  List<HomeAuctions> auctions = [];
  final FAQUseCase faqUseCase;
  final AllAuctionsUseCase allAuctionsUseCase;
  final GetToken getToken;
  final SupportTypeUseCase supportTypeUseCase;
  final HomePageUseCase homePageUseCase;
  final UseCasee getBoutiqueAuctions;
  HomeBloc(this.allAuctionsUseCase, this.homePageUseCase, this.getToken, this.supportTypeUseCase, this.createSupportRequestUseCase, this.faqUseCase, this.getBoutiqueAuctions) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {

          if (event is GetBoutiqueAuctionsEvent){
         emit (Loading());
      var response= await getBoutiqueAuctions.getUsecase("/tradepool/buy-and-sell/get-boutique-ads/?boutique=${event.boutiqe}&page=0&size=1000", ([response]) => boutiqeAuctionsResponseModelFromJson(response));
response.fold((l) => emit(Error(l.error)), (r) => emit(GetBoutiqeAuctionsState(r)));
      
      }



      if (event is GetFAQEvent){
           var token  = await getToken.verficationRepository.getToken();
      var response= await faqUseCase.faqUseCase(token);
      response.fold((l) => emit(Error(l.error)), (r) => emit(GetFAQState(r)));
      }

      if (event is CreateSupportRequestEvent){
        var token  = await getToken.verficationRepository.getToken();
        var response  = await createSupportRequestUseCase.createSupportRequestuseCase(token,event.supportId, event.text);
        response.fold((l) => emit(Error(l.error)), (r) => emit(CreateSupportRequestState()));
      }
      if (event is SupportTypeEvent){
        emit(LoadingSupportTypeState());
        var response = await supportTypeUseCase.supportTypeUseCase(event.code);
        response.fold((l) => emit(Error(l.error)), (r) => emit(SupportTypeState(r)));
      }
      if (event is GetAuctionsEvent) {
        emit(Loading());

        var response =
            await allAuctionsUseCase.getAllAuctions(event.page, event.size);
        response.fold((l) => emit(Error(l.error)), (r) {
          log(auctions.length.toString());
          if (auctions.isEmpty) {
            auctions = r.content;
            emit(GetAuctionsState(auctions));
          } else {
            auctions.addAll(r.content);
            emit(GetAuctionsState(auctions));
          }
        });
      }
      if (event is GetHomePageEvent){
        emit(Loading());
        
        var token = await getToken.verficationRepository.getToken();
        var response = await homePageUseCase.homePageUseCase(token);
        response.fold((l) => emit(Error(l.error)), (r) => emit( GetHomePageState (r)
));
        
      }
    });
  }



}
