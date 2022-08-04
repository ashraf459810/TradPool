part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetMainCategoryEvent extends SearchEvent{}


class GetSubCategoryEvent extends SearchEvent {
  final String parentIdl;

  const GetSubCategoryEvent(this.parentIdl);

}

class GetBrandsForSubCategoriesEvent extends SearchEvent{
  final String parentId;

  const GetBrandsForSubCategoriesEvent(this.parentId);
}

class GetSearchEvent extends SearchEvent {
  final SearchRequestModel searchRequestModel;

const  GetSearchEvent(this.searchRequestModel);
}