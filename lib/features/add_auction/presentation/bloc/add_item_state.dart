part of 'add_item_bloc.dart';

abstract class AddItemState extends Equatable {
  const AddItemState();

  @override
  List<Object> get props => [];
}

class AddItemInitial extends AddItemState {}

class GetMainCategoriesState extends AddItemState {
  final List<MainCategories> mainCategories;

  const GetMainCategoriesState(this.mainCategories);
}

class GetSubCategoriesState extends AddItemState {
  final List<SubCategories> subCategories;

  const GetSubCategoriesState(this.subCategories);
}

class Loading extends AddItemState {}

class LoadingSubCategory extends AddItemState {}

class LoadingBrand extends AddItemState {}

class Error extends AddItemState {
  final String error;

  const Error(this.error);
}

class AddAuctionState extends AddItemState {
  final String result;

  const AddAuctionState(this.result);
}

class GetBransForSubCategoryState extends AddItemState {
  final List<BrandsForSubCategoryModel> brands;

  const GetBransForSubCategoryState(this.brands);
}

class AddFileState extends AddItemState {
  final List<AddFileResponse> addFileResponse;

  const AddFileState(this.addFileResponse);
}

class LoadingFileToUpload extends AddItemState {}


class GetTagsState extends AddItemState {
  final List<String> tags;

 const GetTagsState(this.tags);
}


class LoadingGetTagsState extends  AddItemState{

}


class CalculateAuctionState  extends AddItemState{
   final CalculateResponseModel calculateResponseModel;

const  CalculateAuctionState(this.calculateResponseModel);
}