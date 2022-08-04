// To parse this JSON data, do
//
//     final allAuctionsModel = allAuctionsModelFromJson(jsonString);

import 'dart:convert';

AllAuctionsModel allAuctionsModelFromJson(String str) =>
    AllAuctionsModel.fromJson(json.decode(str));

String allAuctionsModelToJson(AllAuctionsModel data) =>
    json.encode(data.toJson());

class AllAuctionsModel {
  AllAuctionsModel({
    this.content,
   
    this.pageable,
    this.last,
    this.totalPages,
    this.totalElements,
    this.sort,
    this.first,
    this.numberOfElements,
    this.size,
    this.number,
    this.empty,
  });

  List<HomeAuctions> content;
   
  Pageable pageable;
  bool last;
  int totalPages;
  int totalElements;
  Sort sort;
  bool first;
  int numberOfElements;
  int size;
  int number;
  bool empty;

  factory AllAuctionsModel.fromJson(Map<String, dynamic> json) =>
      AllAuctionsModel(
               
        content: List<HomeAuctions>.from(
            json["content"].map((x) => HomeAuctions.fromJson(x))),
        pageable: Pageable.fromJson(json["pageable"]),
        last: json["last"],
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        sort: Sort.fromJson(json["sort"]),
        first: json["first"],
        numberOfElements: json["numberOfElements"],
        size: json["size"],
        number: json["number"],
        empty: json["empty"],
      );

  Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "pageable": pageable.toJson(),
        "last": last,
        "totalPages": totalPages,
        "totalElements": totalElements,
        "sort": sort.toJson(),
        "first": first,
        "numberOfElements": numberOfElements,
        "size": size,
        "number": number,
        "empty": empty,
      };
}

class HomeAuctions {
  HomeAuctions({
    this.version,
    this.tags,
    this.creationDate,
    this.lastModificationDate,
    this.id,
    this.objectType,
    this.attachments,
    this.name,
    this.seller,
    this.mainCategory,
    this.subCategory,
    this.brand,
    this.productCondition,
    this.status,
    this.deliverType,
    this.shippingPayer,
    this.startPrice,
    this.minPrice,
    this.directSellEnabled,
    this.directSellPrice,
    this.length,
    this.width,
    this.height,
    this.description,
    this.days,
    this.hourOfEnd,
    this.minuteOfEnd,
    this.endDate,
    this.fixedSellEnabled,
    this.auctionSellEnabled,
    this.shareMobile,
    this.shareEmail,
    this.bidRequests,
  });

  int version;
  
  DateTime creationDate;
  List<String> tags;
  DateTime lastModificationDate;
  String id;
  String objectType;
  List<Attachment> attachments;
  String name;
  Seller seller;
  Category mainCategory;
  Category subCategory;
  dynamic brand;
  dynamic productCondition;
  String status;
  String deliverType;
  dynamic shippingPayer;
  int startPrice;
  dynamic minPrice;
  
  bool directSellEnabled;
  dynamic directSellPrice;
  dynamic length;
  double width;
  double height;
  String description;
  int days;
  dynamic hourOfEnd;
  dynamic minuteOfEnd;
  DateTime endDate;
  bool fixedSellEnabled;
  bool auctionSellEnabled;
  bool shareMobile;
  bool shareEmail;
  List<BidRequest> bidRequests;

  factory HomeAuctions.fromJson(Map<String, dynamic> json) => HomeAuctions(
        version: json["version"],
        creationDate: DateTime.parse(json["creationDate"]),
        lastModificationDate: DateTime.parse(json["lastModificationDate"]),
              tags: List<String>.from(json["tags"].map((x) => x)),
        id: json["id"],
        objectType: json["objectType"],
        attachments: List<Attachment>.from(
            json["attachments"].map((x) => Attachment.fromJson(x))),
        name: json["name"],
        seller: Seller.fromJson(json["seller"]),
        mainCategory: Category.fromJson(json["mainCategory"]),
        subCategory: Category.fromJson(json["subCategory"]),
        brand: json["brand"] == null ? null : Category.fromJson(json["brand"]),
        productCondition: json["productCondition"],
        status: json["status"],
        deliverType: json["deliverType"],
        shippingPayer: json["shippingPayer"],
        startPrice: json["startPrice"],
        minPrice: json["minPrice"],
        directSellEnabled: json["directSellEnabled"],
        directSellPrice: json["directSellPrice"],
        length: json["length"],
        width: json["width"],
        height: json["height"],
        description: json["description"],
        days: json["days"],
        hourOfEnd: json["hourOfEnd"],
        minuteOfEnd: json["minuteOfEnd"],
        endDate: DateTime.parse(json["endDate"]),
        fixedSellEnabled: json["fixedSellEnabled"],
        auctionSellEnabled: json["auctionSellEnabled"],
        shareMobile: json["shareMobile"],
        shareEmail: json["shareEmail"],
        bidRequests: List<BidRequest>.from(
            json["bidRequests"].map((x) => BidRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "creationDate": creationDate.toIso8601String(),
        "lastModificationDate": lastModificationDate.toIso8601String(),
        "id": id,
        "objectType": objectType,
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
        "name": name,
        "seller": seller.toJson(),
        "mainCategory": mainCategory.toJson(),
        "subCategory": subCategory.toJson(),
        "brand": brand,
        "productCondition": productCondition,
        "status": status,
        "deliverType": deliverType,
        "shippingPayer": shippingPayer,
        "startPrice": startPrice,
        "minPrice": minPrice,
        "directSellEnabled": directSellEnabled,
        "directSellPrice": directSellPrice,
        "length": length,
        "width": width,
        "height": height,
        "description": description,
        "days": days,
        "hourOfEnd": hourOfEnd,
        "minuteOfEnd": minuteOfEnd,
        "endDate": endDate.toIso8601String(),
        "fixedSellEnabled": fixedSellEnabled,
        "auctionSellEnabled": auctionSellEnabled,
        "shareMobile": shareMobile,
        "shareEmail": shareEmail,
        "bidRequests": List<dynamic>.from(bidRequests.map((x) => x)),
      };
}

class Attachment {
  Attachment({
    this.version,
    this.creationDate,
    this.lastModificationDate,
    this.id,
    this.objectType,
    this.attachments,
    this.tag,
    this.extension,
    this.path,
    this.publicUrl,
    this.ownerId,
    this.ownerType,
    this.deleted,
    this.linked,
  });

  int version;
  DateTime creationDate;
  DateTime lastModificationDate;
  String id;
  String objectType;
  List<dynamic> attachments;
  String tag;
  String extension;
  String path;
  String publicUrl;
  String ownerId;
  String ownerType;
  bool deleted;
  bool linked;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        version: json["version"],
        // creationDate: DateTime.parse(json["creationDate"]),
        // lastModificationDate: DateTime.parse(json["lastModificationDate"]),
        id: json["id"],
        objectType: json["objectType"],
        attachments: json["attachments"] !=null? List<Attachment>.from(json["attachments"].map((x) => x)):null,
        tag: json["tag"],
        extension: json["extension"],
        path: json["path"],
        publicUrl: json["publicURL"],
        ownerId: json["ownerId"],
        ownerType: json["ownerType"],
        deleted: json["deleted"],
        linked: json["linked"],
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "creationDate": creationDate.toIso8601String(),
        "lastModificationDate": lastModificationDate.toIso8601String(),
        "id": id,
        "objectType": objectType,
        "attachments": List<dynamic>.from(attachments.map((x) => x)),
        "tag": tag,
        "extension": extension,
        "path": path,
        "publicURL": publicUrl,
        "ownerId": ownerId,
        "ownerType": ownerType,
        "deleted": deleted,
        "linked": linked,
      };
}

class Category {
  Category({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Seller {
  Seller({
    this.name,
  });

  String name;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Pageable {
  Pageable({
    this.sort,
    this.pageNumber,
    this.pageSize,
    this.offset,
    this.paged,
    this.unpaged,
  });

  Sort sort;
  int pageNumber;
  int pageSize;
  int offset;
  bool paged;
  bool unpaged;

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        sort: Sort.fromJson(json["sort"]),
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        offset: json["offset"],
        paged: json["paged"],
        unpaged: json["unpaged"],
      );

  Map<String, dynamic> toJson() => {
        "sort": sort.toJson(),
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "offset": offset,
        "paged": paged,
        "unpaged": unpaged,
      };
}

class Sort {
  Sort({
    this.sorted,
    this.unsorted,
    this.empty,
  });

  bool sorted;
  bool unsorted;
  bool empty;

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        sorted: json["sorted"],
        unsorted: json["unsorted"],
        empty: json["empty"],
      );

  Map<String, dynamic> toJson() => {
        "sorted": sorted,
        "unsorted": unsorted,
        "empty": empty,
      };
}

class BidRequest {
  BidRequest({
    this.bidder,
    this.creationDate,
    this.price,
  });

  Seller bidder;
  DateTime creationDate;
  int price;

  factory BidRequest.fromJson(Map<String, dynamic> json) => BidRequest(
        bidder: Seller.fromJson(json["bidder"]),
        creationDate: DateTime.parse(json["creationDate"]),
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "bidder": bidder.toJson(),
        "creationDate": creationDate.toIso8601String(),
        "price": price,
      };
}


