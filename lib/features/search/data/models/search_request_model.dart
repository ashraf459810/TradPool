class SearchRequestModel {

   String mainCategoryId;
   String subCategoryId;
   String  brandId ;
   String minPrice;
   String maxPrice;
   String condition;
   bool isFixed;
   bool isAuction;
   String deliverType;
   String shippingBuyer;
   String location;
   int page ;
   int size ;
   String name;

  SearchRequestModel(this.mainCategoryId, this.subCategoryId, this.brandId, this.minPrice, this.maxPrice, this.condition, this.isFixed, this.isAuction, this.deliverType, this.shippingBuyer, this.location, this.page, this.size, this.name);






}