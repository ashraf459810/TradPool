part of 'add_item_bloc.dart';

abstract class AddItemEvent extends Equatable {
  const AddItemEvent();

  @override
  List<Object> get props => [];
}

class GetMainCategoriesEvent extends AddItemEvent {}

class GetSubCategoriesEvent extends AddItemEvent {
  final String parent;

  const GetSubCategoriesEvent(this.parent);
}

class GetBrandsForSubCategoriesEvent extends AddItemEvent {
  final String parent;

  const GetBrandsForSubCategoriesEvent(this.parent);
}

class AddAuctionEvent extends AddItemEvent {
  final AuctionBody auctionBody;
  final String imageId;
  final String address;

  const AddAuctionEvent(this.auctionBody, this.imageId, this.address);
}

class UploadFileEvent extends AddItemEvent {
  final String name;
  final List<XFile> image;

  const UploadFileEvent(this.name, this.image);
}


class GetTagsEvent extends AddItemEvent{
  final String categoryId;

  const GetTagsEvent(this.categoryId);
}


class CalculateAuctionEvent extends AddItemEvent{

 final AuctionBody auctionBody;

  const CalculateAuctionEvent(this.auctionBody);

}