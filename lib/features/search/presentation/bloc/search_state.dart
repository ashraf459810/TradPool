part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();  

  @override
  List<Object> get props => [];
}
class SearchInitial extends SearchState {}




class GetMainCategoriesState extends SearchState {
  final List<MainCategories> mainCategories;

  const GetMainCategoriesState(this.mainCategories);
}

class GetSubCategoriesState extends SearchState {
  final List<SubCategories> subCategories;

  const GetSubCategoriesState(this.subCategories);
}

class Loading extends SearchState {}

class LoadingSubCategory extends SearchState {}

class LoadingBrand extends SearchState {}

class Error extends SearchState {
  final String error;

  const Error(this.error);
}
class GetBransForSubCategoryState extends SearchState {
  final List<BrandsForSubCategoryModel> brands;

  const GetBransForSubCategoryState(this.brands);
}

class GetSearchState extends SearchState {
  final SearchResponseModel searchResponseModel ;

const GetSearchState(this.searchResponseModel);
}

class LoadingSearch extends SearchState{}