import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/core/error/failures.dart';
import 'package:tradpool/features/add_auction/data/models/add_file_response.dart';
import 'package:tradpool/features/add_auction/data/models/auction_body.dart';
import 'package:tradpool/features/add_auction/data/models/brands_for_sub_category.dart';
import 'package:tradpool/features/add_auction/data/models/calculate_response_model.dart';
import 'package:tradpool/features/add_auction/data/models/main_category.dart';
import 'package:tradpool/features/add_auction/data/models/sub_category.dart';
import 'package:tradpool/features/add_auction/domain/usecases/add_auction_use_case.dart';
import 'package:tradpool/features/add_auction/domain/usecases/calculate_auction_use_case.dart';
import 'package:tradpool/features/add_auction/domain/usecases/get_brands_for_sub_use_case.dart';
import 'package:tradpool/features/add_auction/domain/usecases/get_main_category_use_case.dart';
import 'package:tradpool/features/add_auction/domain/usecases/get_sub_categories_use_case.dart';
import 'package:tradpool/features/add_auction/domain/usecases/get_tags_use_case.dart';
import 'package:tradpool/features/add_auction/domain/usecases/upload_file_use_case.dart';

part 'add_item_event.dart';
part 'add_item_state.dart';

class AddItemBloc extends Bloc<AddItemEvent, AddItemState> {
  final CaluculateAuctionUseCase caluculateAuctionUseCase;
  final GetTagsUseCase getTagsUseCase;
  final GetMainCategoriesUseCase getMainCategoriesUseCase;
  final GetSubCategoriesUseCase getSubCategoriesUseCase;
  final AddAuctionUseCase addAuctionUseCase;
  final UploadFileUseCase uploadFileUseCase;
  final BrandsForSubCategoryUseCase brandsForSubCategoryUseCase;
  Either<Failure, List<MainCategories>> mainCategoryResponse;
  Either<Failure, List<SubCategories>> subCategoryResponse;
  Either<Failure, List<BrandsForSubCategoryModel>> brandsresponse;
  Either<Failure, String> addAuctionResponse;
  void params;
  AddItemBloc(
      this.getMainCategoriesUseCase,
      this.getSubCategoriesUseCase,
      this.addAuctionUseCase,
      this.brandsForSubCategoryUseCase,
      this.uploadFileUseCase, this.getTagsUseCase, this.caluculateAuctionUseCase)
      : super(AddItemInitial()) {
    on<AddItemEvent>((event, emit) async {

      if (event is CalculateAuctionEvent){
        emit (Loading());
          AuctionBody auctionBody = event.auctionBody;
        final shared = await SharedPreferences.getInstance();
        String token = shared.getString(Con.token);
        auctionBody.seller = Obj(id: token);
        var response = await caluculateAuctionUseCase.calculateUseCase( event.auctionBody);
        response.fold((l) => emit(Error(l.error)), (r) => emit(CalculateAuctionState(r)));
      }

if (event is GetTagsEvent){
  emit (LoadingGetTagsState());
  var response= await getTagsUseCase.getTagsUseCase(event.categoryId);
  response.fold((l) => emit(Error(l.error)), (r) => emit(GetTagsState(r)));
}

      if (event is GetMainCategoriesEvent) {
        log("here");
        emit(Loading());

        mainCategoryResponse = await getMainCategoriesUseCase.call();

        mainCategoryResponse.fold((l) => emit(Error(l.error)),
            (r) => emit(GetMainCategoriesState(r)));
      }
      if (event is GetSubCategoriesEvent) {
        emit(LoadingSubCategory());
        log("here from the sub categoties bloc");
        subCategoryResponse = await getSubCategoriesUseCase.call(event.parent);
        subCategoryResponse.fold((l) => emit(Error(l.error)), (r) {
          emit(GetSubCategoriesState(r));
        });
      }
      if (event is GetBrandsForSubCategoriesEvent) {
        emit(LoadingBrand());
        brandsresponse = await brandsForSubCategoryUseCase.call(event.parent);
        
        brandsresponse.fold((l) => emit(Error(l.error)), (r) {
          log('here from state in bloc')
;          emit(GetBransForSubCategoryState(r));
        });
      }

      if (event is AddAuctionEvent) {
        emit(Loading());
        AuctionBody auctionBody = event.auctionBody;
        final shared = await SharedPreferences.getInstance();
        String token = shared.getString(Con.token);
        auctionBody.seller = Obj(id: token);
        addAuctionResponse = await addAuctionUseCase.addAuctionUseCase(auctionBody, event.imageId,event.address);
        addAuctionResponse.fold(
            (l) => emit(Error(l.error)), (r) => emit(AddAuctionState(r)));
      }

      if (event is UploadFileEvent) {
        emit(LoadingFileToUpload());

        final response =
            await uploadFileUseCase.uploadimage(event.name, event.image);

        response.fold(
            (l) => emit(Error(l.error)), (r) => emit(AddFileState(r)));
      }
    });
  }
}
