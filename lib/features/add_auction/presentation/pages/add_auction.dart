


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/App/app_localizations.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/container.dart';

import 'package:tradpool/Widgets/nav.dart';

import 'package:tradpool/Widgets/text.dart';

import 'package:tradpool/features/add_auction/data/models/auction_body.dart';
import 'package:tradpool/features/add_auction/data/models/brands_for_sub_category.dart';

import 'package:tradpool/features/add_auction/data/models/main_category.dart';
import 'package:tradpool/features/add_auction/data/models/sub_category.dart';

import 'package:tradpool/features/add_auction/presentation/bloc/add_item_bloc.dart';
import 'package:tradpool/features/add_auction/presentation/pages/add_auction_details.dart';

import 'package:tradpool/features/add_auction/presentation/widgets/loading.dart';
import 'package:tradpool/features/add_auction/presentation/widgets/three_dash.dart';
import 'package:tradpool/features/login/presentation/widgets/confirm_button.dart';
import 'package:tradpool/features/login/presentation/widgets/input_container.dart';
import 'package:tradpool/features/register/presentation/widgets/input_drop.dart';

import '../../../../injection_container.dart';

class AddAuction extends StatefulWidget {
  const AddAuction({
    Key key,
  }) : super(key: key);

  @override
  _AddAuctionState createState() => _AddAuctionState();
}

class _AddAuctionState extends State<AddAuction> {
  int cost  ;
  String category;
  String subCategory;
  String brand;
  String status;
  bool auction = false;
  bool fixed = false;
  String mainCategoryId;
  MainCategories chosenMainCategory;
  String subCategoryId;
  String brandId;
  String additionalinfo;
  TextEditingController additionalinfoc = TextEditingController();
  String productName;
  AddItemBloc addItemBloc = sl<AddItemBloc>();
  TextEditingController productNamec = TextEditingController();
  TextEditingController brandc = TextEditingController();
  List<MainCategories> mainCategory = [];
  List<SubCategories> subcategory = [];
  List<BrandsForSubCategoryModel> brands = [];
  List<String> matchedbrands = [];
  AuctionBody auctionBody;
  List<String> tags = [];
  List<String> matchedTags = [];
  List<String> selectedTags = [];
  TextEditingController tagsc = TextEditingController();

  @override
  void initState() {
    addItemBloc.add(GetMainCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: text(
          text: "Add New Ads",
          color: Colors.black,
          fontsize: 14.sp,
        ),
        centerTitle: true,
        foregroundColor: Colors.grey[50],
        backgroundColor: Colors.grey[50],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: h(54),
                  ),
                  const ThreeDash(
                    selected: 0,
                  ),
                ],
              ),
              SizedBox(
                height: h(40),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w(28)),
                child: Row(
                  children: [
                    text(
                        text:
                            "Complete the steps to open auction for a product .",
                        color: AppColor.hintcolor)
                  ],
                ),
              ),
              SizedBox(
                height: h(17),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  inputContainer(
                      width: w(330),
                      controller: productNamec,
                      validation: "name",
                      maxlines: 1,
                      hint: AppLocalizations.of(context).translate( "Enter Product Name"),
                      value: (val) {
                        productName = val;
                      }),
                ],
              ),
              SizedBox(
                height: h(25),
              ),
              BlocBuilder(
                bloc: addItemBloc,
                builder: (context, state) {
                  if (state is Loading) {
                    return const LoadingState();
                  }
                  if (state is GetMainCategoriesState) {
                    mainCategory = state.mainCategories;
                  }

                  return IgnorePointer(
                    ignoring: (state is Loading),
                    child: Column(
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SizedBox(width: 10.w,),
                            inputDrop(
                                width: cost==null ? 330.w: w(250),
                                chosenvalue: category,
                                hint: AppLocalizations.of(context).translate("Select Category"),
                                list: mainCategory,
                                value: (value) {
                                  chosenMainCategory = value ;
                    
                                  mainCategoryId = value.id;
                                  cost = value.adCost;
               
                                  category = value.name ;

                                      addItemBloc
                                      .add(GetSubCategoriesEvent(value.id.toString()));

                                  addItemBloc
                                      .add(GetTagsEvent(value.id.toString()));

                                }),
                   

                               cost!=null?            container(width: 100.h,
                               color: Colors.transparent,
                             
                                 hight: 50.h,child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                      SizedBox(width: 40.w,
                                        child: text(text: "Cost",color: AppColor.blue)),
                                    
                                      SizedBox(width: 30.w,
                                        child: text(text: cost.toString(),color: AppColor.blue))
                                 ],),):const SizedBox()
                          ],
                          
                        ),
                                 chosenMainCategory != null &&
                                    chosenMainCategory.additionalField != null
                                ? SizedBox(
                                    height: h(17),
                                  )
                                : const SizedBox(),
                      
                              chosenMainCategory != null &&
                                    chosenMainCategory.additionalField != null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      inputContainer(
                                          width: w(330),
                                          controller: additionalinfoc,
                                          validation: "name",
                                          maxlines: 1,
                                          hint:
                                              "Enter ${chosenMainCategory.additionalField}",
                                          value: (val) {
                                            additionalinfo = val;
                                          }),
                                    ],
                                  )
                                : const SizedBox(),
                      ],
                    ),
                  );
                },
            



              ),
              SizedBox(height: 20.h,),
     
           
              BlocBuilder(
                bloc: addItemBloc,
                builder: (context, state) {
                  if (state is Error) {
           
                  }
                  if (state is GetTagsState) {
                
                    tags = state.tags;

                    addItemBloc.add(GetSubCategoriesEvent(mainCategoryId));
                  }
                  if (state is LoadingGetTagsState) {
               
                    return const Center(child: LoadingState());
                  }

                  return Column(
                    children: [
                      Column(
                        children: [
                          container(
                            width: w(330),
                            // chosenvalue: brand,
                            hight: h(50),
                            borderRadius: 5,
                            bordercolor: AppColor.grey,
                            child: TextFormField(
                              controller: tagsc,
                              decoration: InputDecoration(
                                  hintText: "  " + AppLocalizations.of(context).translate( "select your tags"),
                                  hintStyle: TextStyle(
                                      color: AppColor.hintcolor,
                                      fontSize: 13.sp),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: w(10), bottom: h(5))),
                              maxLines: 1,
                              onChanged: (value) {
                                if (value != ("")) {
                                  if (value.length == 1) {
                                    value = value.toUpperCase();
                                  }

                                  for (var i = 0; i < tags.length; i++) {
                                    if (tags[i].contains(value)) {
                                      if (!matchedTags.contains(tags[i])) {
                                        matchedTags.add(tags[i]);
                                      }
                                    }
                                    if (tags[i].startsWith(value)) {
                                      if (!matchedTags.contains(tags[i])) {
                                        matchedTags.add(tags[i]);
                                      }
                                    }
                                  }

                                  setState(() {});
                                } else {
                                  matchedTags.clear();
                                  setState(() {});
                                }
                              },
                              onFieldSubmitted: (value) {
                              
                                matchedTags.clear();
                                if (!selectedTags.contains(value))
{                                selectedTags.add(value);}
                                tagsc.clear();
                                setState(() {
                                  
                                });
                              },
                            ),
                          ),
                          matchedTags.isNotEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: w(15.0), right: w(15)),
                                  child: Container(
                                    width: w(330),
                                    color: Colors.grey[200],
                                    height: h(120),
                                    child: ListView.builder(
                                      itemCount: matchedTags.length,
                                      itemBuilder: (context, index) {
                                   
                                        return GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                            tagsc.text = matchedTags[index];

                                            if (!selectedTags
                                                .contains(tagsc.text)) {
                                              selectedTags
                                                  .add(matchedTags[index]);
                                            }

                                            matchedTags = [];
                                            tagsc.clear();

                                            setState(() {});
                                          },
                                          child: ListTile(
                                            title: Text(matchedTags[index]),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          selectedTags.isNotEmpty
                              ? SizedBox(
                                  height: h(50),
                                  width: w(330),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: selectedTags.length,
                                    itemBuilder: (context, index) {
                          
                                      return container(
                                        color: Colors.transparent,
                                        width: w(150),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  selectedTags.removeAt(index);
                                                  setState(() {});
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  size: 20,
                                                )),
                                          container(
                                            color: AppColor.blue,
                                            borderRadius: 10,
                                            width: w(100),
                                            hight: h(30),
                                            child: Text(selectedTags[index]),

                                          ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
                      // SizedBox(
                      //   height: h(17),
                      // ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: h(17),
              ),
              BlocBuilder(
                  bloc: addItemBloc,
                  builder: (context, state) {
                    if (state is LoadingSubCategory) {
                      return const LoadingState();
                    }
                    if (state is GetSubCategoriesState) {
                      subcategory = state.subCategories;
                    }
                    return Column(
                      children: [
                        inputDrop(
                            width: w(330),
                            chosenvalue: subCategory,
                            hint: AppLocalizations.of(context).translate( "Select Sub Category"),
                            list: subcategory,
                            value: (value) {
                              subCategory = value.name;
                              subCategoryId = value.id;
                              brands = [];

                              addItemBloc.add(GetBrandsForSubCategoriesEvent(
                                  value.id.toString()));
                            }),
                        SizedBox(
                          height: h(17),
                        ),
                      ],
                    );
                  }),
              BlocBuilder(
                bloc: addItemBloc,
                builder: (context, state) {
                  if (state is LoadingBrand) {
                    return const LoadingState();
                  }
                  if (state is GetBransForSubCategoryState) {
                    brands = state.brands;
            

                    if (state.brands.isEmpty) {
                      return const SizedBox();
                    } else {
                      return Column(
                        children: [
                          Column(
                            children: [
                              container(
                                width: w(330),
                                // chosenvalue: brand,
                                hight: h(50),
                                borderRadius: 5,
                                bordercolor: AppColor.grey,
                                child: TextFormField(
                                  controller: brandc,
                                  decoration: InputDecoration(
                                      hintText:AppLocalizations.of(context).translate( "select your brand"),
                                      hintStyle: TextStyle(
                                          color: AppColor.hintcolor,
                                          fontSize: 13.sp),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: w(10), bottom: h(5))),
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value != ("")) {
                                      if (value.length == 1) {
                                        value = value.toUpperCase();
                                      }

                                      for (var i = 0; i < brands.length; i++) {
                                        if (brands[i].name.contains(value)) {
                                          if (!matchedbrands
                                              .contains(brands[i].name)) {
                                            matchedbrands.add(brands[i].name);
                                          }
                                        }
                                        if (brands[i].name.startsWith(value)) {
                                          if (!matchedbrands
                                              .contains(brands[i].name)) {
                                            matchedbrands.add(brands[i].name);
                                          }
                                        }
                                      }

                                      setState(() {});
                                    } else {
                                      matchedbrands.clear();
                                      setState(() {});
                                    }
                                  },
                                ),
                              ),
                              matchedbrands.isNotEmpty
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          left: w(15.0), right: w(15)),
                                      child: Container(
                                        color: Colors.grey[200],
                                        height: h(120),
                                        width: w(330),
                                        child: ListView.builder(
                                          itemCount: matchedbrands.length,
                                          itemBuilder: (context, index) {
                                           
                                            
                                            return GestureDetector(
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                brandc.text =
                                                    matchedbrands[index];

                                                matchedbrands = [];

                                                setState(() {});
                                              },
                                              child: ListTile(
                                                title:
                                                    Text(matchedbrands[index]),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          SizedBox(
                            height: h(17),
                          ),
                        ],
                      );
                    }
                  }
                  return const SizedBox();
                },
              ),
              inputDrop(
                  width: w(330),
                  chosenvalue: category,
                  hint: AppLocalizations.of(context).translate( "Select Status"),
                  list: ["NEW", "USED"],
                  value: (value) {
                    status = value;
                  }),
              SizedBox(
                height: h(20),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w(28)),
                child: Row(
                  children: [
                    text(text: "Type of selling", color: AppColor.hintcolor)
                  ],
                ),
              ),
              SizedBox(
                height: h(17),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w(28)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: w(4),
                    ),
                    SvgPicture.asset("assets/images/questionmark.svg"),
                    Checkbox(
                      fillColor: MaterialStateProperty.all(AppColor.blue),
                      value: fixed,
                      onChanged: (bool value) {
                        setState(() {
                          fixed = value;
                        });
                      },
                    ),
                    SizedBox(
                      width: w(7),
                    ),
                    text(text: "Fixed Price", color: AppColor.hintcolor)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w(28)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: w(4),
                    ),
                    SvgPicture.asset("assets/images/questionmark.svg"),
                    Checkbox(
                      fillColor: MaterialStateProperty.all(AppColor.blue),
                      // checkColor: AppColor.blue,
                      value: auction,
                      onChanged: (bool value) {
                        setState(() {
                          auction = value;
                        });
                      },
                    ),
                    SizedBox(
                      width: w(7),
                    ),
                    text(text: "Auction", color: AppColor.hintcolor)
                  ],
                ),
              ),
              SizedBox(
                height: h(20),
              ),
              InkWell(
                  onTap: () {
                    if (fixed == false &&
                        auction == true &&
                        productName != null &&
                        category != null &&
                        subCategory != null &&
                        status != null) {
                      auctionBody = AuctionBody(
                        additionalInfo: additionalinfo,
                        tags: selectedTags,
                        name: productName,
                        mainCategory: Obj(id: mainCategoryId),
                        subCategory: Obj(id: subCategoryId),
                        brand: brandc.text,
                        condition: status,
                        fixedSellEnabled: fixed,
                        auctionSellEnabled: auction,
                      );
                      nav(
                          context,
                          AddAuctionDetails(
                            auctionBody: auctionBody,
                            isFixed: false,
                            isMixed: false,
                            isauction: true,
                          ));
                    } else if (fixed == true &&
                        productName != null &&
                        auction == false &&
                        category != null &&
                        subCategory != null &&
                        status != null) {
                      auctionBody = AuctionBody(
                        additionalInfo: additionalinfo,
                        tags: selectedTags,
                        name: productName,
                        mainCategory: Obj(id: mainCategoryId),
                        subCategory: Obj(id: subCategoryId),
                        brand: brandc.text,
                        condition: status,
                        fixedSellEnabled: fixed,
                        auctionSellEnabled: auction,
                      );
                      nav(
                          context,
                          AddAuctionDetails(
                            isFixed: true,
                            isMixed: false,
                            isauction: false,
                            auctionBody: auctionBody,
                          ));
                    } else if (fixed &&
                        auction &&
                        productName != null &&
                        category != null &&
                        subCategory != null &&
                        status != null) {
                      auctionBody = AuctionBody(
                        additionalInfo: additionalinfo,
                        tags: selectedTags,
                        name: productName,
                        mainCategory: Obj(id: mainCategoryId),
                        subCategory: Obj(id: subCategoryId),
                        brand: brandc.text,
                        condition: status,
                        fixedSellEnabled: fixed,
                        auctionSellEnabled: auction,
                      );
                      nav(
                          context,
                          AddAuctionDetails(
                            isFixed: false,
                            isMixed: true,
                            isauction: false,
                            auctionBody: auctionBody,
                          ));
                    } else {
                      Toast.show(     AppLocalizations.of(context).translate(         "Please Complete Your Informations first"), context);
                    }
                  },
                  child: confirmButton(hint: "Continue", width: w(250))),
              SizedBox(
                height: h(10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
