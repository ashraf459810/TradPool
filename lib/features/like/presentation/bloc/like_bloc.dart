import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tradpool/features/home/data/model/favourite_model.dart';
import 'package:tradpool/features/like/domain/use_case/add_to_favourite_use_case.dart';
import 'package:tradpool/features/like/domain/use_case/fetch_user_favourite_use_case.dart';
import 'package:tradpool/features/verfication/domain/usecases/user_info_use_case.dart';

part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  final AddToFavouriteUseCase addToFavouriteUseCase ;
  final FetchUserFavouriteUseCase fetchUserFavouriteUseCase;
  final GetToken getToken ;

  LikeBloc(this.addToFavouriteUseCase, this.fetchUserFavouriteUseCase, this.getToken) : super(LikeInitial()) {
    on<LikeEvent>((event, emit) async{

      if (event is AddToFavouriteEvent){
            var token = await getToken.verficationRepository.getToken();
        var response = await addToFavouriteUseCase.addToFavouriteUseCase(event.auctionId, token,event.likeOrUnlike);
        response.fold((l) => emit(Error( l.error)), (r) => emit(AddToFavouriteState()));
      }
         if (event is FetchUserFavouriteEvent){
           emit (Loading());
              var token = await getToken.verficationRepository.getToken();
           var response = await fetchUserFavouriteUseCase.fetchUserFavouriteUseCase(token);
           response.fold((l) => emit(Error(l.error)), (r) => emit(FetchUserFavouriteState(r)));
         }


    });
  }
}
