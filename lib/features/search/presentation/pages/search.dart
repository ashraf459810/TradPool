import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tradpool/App/app.dart';
import 'package:tradpool/App/app_localizations.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/drop_down.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/Widgets/text_form.dart';

import 'package:tradpool/features/add_auction/presentation/widgets/loading.dart';
import 'package:tradpool/features/home/data/model/home_page_model.dart';

import 'package:tradpool/features/login/presentation/widgets/confirm_button.dart';
import 'package:tradpool/features/search/data/models/search_request_model.dart';
import 'package:tradpool/features/search/data/models/search_response_model.dart';
import 'package:tradpool/features/search/presentation/bloc/search_bloc.dart';
import 'package:tradpool/features/search/presentation/widgets/search_result.dart'
    as wi;


import '../../../../injection_container.dart';

class Search extends StatefulWidget {
  final TrendingBrand trendingBrand;
  const Search({Key key, this.trendingBrand}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  SearchBloc searchBloc = sl<SearchBloc>();
  String name;
  String minPrice;
  String maxPrice;
  String location;
  String mainCategory;
  String subCategory;
  String brand;
  String condition;
  String time;
  String timeUnite;
  var mainCategories = [];
  var subCategories = [];
  var brands = [];
  bool isFixed = false;
  bool isAuction = false;
  String deliveryType;
  String shpping;
  TextEditingController timec = TextEditingController();
  TextEditingController namec = TextEditingController();
  TextEditingController minPricec = TextEditingController();
  TextEditingController maxPricec = TextEditingController();
  TextEditingController locationc = TextEditingController();
  SearchResponseModel searchResponseModel = SearchResponseModel();
  SearchRequestModel searchRequestModel = SearchRequestModel(
      '', '', '', '', '', '', null, null, '', '', '', 0, 20, '');
  @override
  void initState() {
    if (widget.trendingBrand != null) {
      mainCategory = widget.trendingBrand.mainCategory.name;
      searchRequestModel.mainCategoryId = widget.trendingBrand.mainCategory.id;
      searchRequestModel.subCategoryId = widget.trendingBrand.subCategory.id;
      searchRequestModel.brandId = widget.trendingBrand.brand.id;
      searchRequestModel.page = 0;
      subCategory = widget.trendingBrand.subCategory.name;
      brand = widget.trendingBrand.brand.name;
    } else {
      searchBloc.add(GetMainCategoryEvent());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => searchBloc,
      child: Scaffold(
          backgroundColor: Colors.grey[50],
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                  physics: const ScrollPhysics(
                      parent: NeverScrollableScrollPhysics()),
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: h(10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/logo.gif",
                            fit: BoxFit.cover, width: w(170), height: h(30)),
                      ],
                    ),
                    SizedBox(
                      height: h(50),
                    ),
                    container(
                        borderRadius: 5,
                        color: Colors.grey[200],
                        hight: h(50),
                        width: w(330),
                        child: textform(
                            hint:
                                AppLocalizations.of(context).translate('Name'),
                            hintColor: AppColor.hintcolor,
                            controller: namec,
                            function: (val) {
                              name = val;
                              searchRequestModel.name = val;
                            },
                            padding: EdgeInsets.all(h(10)),
                            validation: 'name')),
                    SizedBox(
                      height: h(20),
                    ),
                    BlocBuilder(
                      bloc: searchBloc,
                      builder: (context, state) {
                        if (state is Loading) {
                          return const LoadingState();
                        }
                        if (state is Error) {
                          // return text(text: '400');
                        }
                        if (state is GetMainCategoriesState) {
                          mainCategories = state.mainCategories;
                        }
                        return container(
                            borderRadius: 5,
                            color: Colors.grey[200],
                            hight: h(50),
                            width: w(330),
                            child: DropDown(
                              chosenvalue: mainCategory,
                              getindex: (val) {},
                              onchanged: (val) {
                                mainCategory = val.name;
                                searchRequestModel.mainCategoryId = val.id;
                                subCategories = [];
                                searchBloc.add(GetSubCategoryEvent(val.id));
                              },
                              list: mainCategories,
                              hint: widget.trendingBrand != null
                                  ? mainCategory
                                  : AppLocalizations.of(context)
                                      .translate('category'),
                            ));
                      },
                    ),
                    SizedBox(
                      height: h(20),
                    ),
                    BlocBuilder(
                      bloc: searchBloc,
                      builder: (context, state) {
                        if (state is LoadingSubCategory) {
                          return const LoadingState();
                        }
                        if (state is GetSubCategoriesState) {
                          subCategories = state.subCategories;
                        }
                        return container(
                            borderRadius: 5,
                            color: Colors.grey[200],
                            hight: h(50),
                            width: w(330),
                            child: DropDown(
                              chosenvalue: subCategory,
                              getindex: (val) {},
                              onchanged: (val) {
                                subCategory = val.name;
                                searchRequestModel.subCategoryId = val.id;
                                brands = [];
                                searchBloc.add(
                                    GetBrandsForSubCategoriesEvent(val.id));
                              },
                              list: subCategories,
                              hint: widget.trendingBrand != null
                                  ? subCategory
                                  : AppLocalizations.of(context)
                                      .translate('sub category'),
                            ));
                      },
                    ),
                    SizedBox(
                      height: h(20),
                    ),
                    brands.isNotEmpty || widget.trendingBrand != null
                        ? BlocBuilder(
                            bloc: searchBloc,
                            builder: (context, state) {
                              if (state is LoadingBrand) {
                                return const LoadingState();
                              }
                              return container(
                                  borderRadius: 5,
                                  color: Colors.grey[200],
                                  hight: h(50),
                                  width: w(330),
                                  child: DropDown(
                                    chosenvalue: brand,
                                    getindex: (val) {},
                                    onchanged: (val) {
                                      brand = val.name;
                                      searchRequestModel.brandId = val.id;
                                    },
                                    list: brands,
                                    hint: widget.trendingBrand != null
                                        ? widget.trendingBrand.brand.name
                                        : AppLocalizations.of(context)
                                            .translate('Brand'),
                                  ));
                            },
                          )
                        : const SizedBox(),
                    SizedBox(height: h(20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        container(
                          width: w(150),
                          hight: h(60),
                          color: Colors.grey[200],
                          child: textform(
                            hintColor: AppColor.hintcolor,
                            validation: 'number',
                            padding: EdgeInsets.all(
                              h(10),
                            ),
                            function: (val) {
                              maxPrice = val;
                              searchRequestModel.maxPrice = maxPrice;
                            },
                            controller: maxPricec,
                            hint: AppLocalizations.of(context)
                                .translate('Max Price'),
                          ),
                          borderRadius: 5,
                        ),
                        container(
                          width: w(150),
                          hight: h(60),
                          color: Colors.grey[200],
                          child: textform(
                            hintColor: AppColor.hintcolor,
                            validation: 'number',
                            padding: EdgeInsets.all(
                              h(10),
                            ),
                            function: (val) {
                              minPrice = val;
                              searchRequestModel.minPrice = val;
                            },
                            controller: minPricec,
                            hint: AppLocalizations.of(context)
                                .translate('Min Price'),
                          ),
                          borderRadius: 5,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: h(20),
                    ),
                    container(
                        borderRadius: 5,
                        color: Colors.grey[200],
                        hight: h(50),
                        width: w(330),
                        child: DropDown(
                          chosenvalue: condition,
                          getindex: (val) {},
                          onchanged: (val) {
                            condition = val;
                            searchRequestModel.condition = val;
                          },
                          list: const ['NEW', 'USED'],
                          hint: AppLocalizations.of(context)
                              .translate('Product Condition'),
                        )),
                    SizedBox(height: h(20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                checkColor: Colors.white,
                                activeColor: AppColor.blue,
                                value: isAuction,
                                onChanged: (bool value) {
                                  setState(() {
                                    isAuction = value;
                                    searchRequestModel.isAuction = value;
                                  });
                                }),
                            text(text: 'Auction', color: AppColor.darkBlue),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                checkColor: Colors.white,
                                activeColor: AppColor.blue,
                                value: isFixed,
                                onChanged: (bool value) {
                                  setState(() {
                                    isFixed = value;
                                    searchRequestModel.isFixed = value;
                                  });
                                }),
                            text(text: 'Fixed Price', color: AppColor.darkBlue),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: h(20),
                    ),
                    container(
                        borderRadius: 5,
                        color: Colors.grey[200],
                        hight: h(50),
                        width: w(330),
                        child: DropDown(
                          chosenvalue: deliveryType,
                          getindex: (val) {},
                          onchanged: (val) {
                            deliveryType = val;
                            searchRequestModel.deliverType = val;
                          },
                          list: [
                            AppLocalizations.of(context)
                                .translate('HAND_BY_HAND'),
                            AppLocalizations.of(context).translate('SHIPPING')
                          ],
                          hint: 'Deliver type',
                        )),
                    SizedBox(height: h(20)),
                    SizedBox(
                      height: h(20),
                    ),
                    container(
                        borderRadius: 5,
                        color: Colors.grey[200],
                        hight: h(50),
                        width: w(330),
                        child: DropDown(
                          chosenvalue: shpping,
                          getindex: (val) {},
                          onchanged: (val) {
                            shpping = val;
                            searchRequestModel.shippingBuyer = val;
                          },
                          list: [
                            AppLocalizations.of(context).translate('BUYER'),
                            AppLocalizations.of(context).translate("SELLER")
                          ],
                          hint: 'Shipping Payer',
                        )),
                    SizedBox(height: h(20)),
                    container(
                        borderRadius: 5,
                        color: Colors.grey[200],
                        hight: h(50),
                        width: w(330),
                        child: textform(
                            hintColor: AppColor.hintcolor,
                            hint: AppLocalizations.of(context)
                                .translate('Location'),
                            controller: locationc,
                            function: (val) {
                              location = val;
                              searchRequestModel.location = val;
                            },
                            padding: EdgeInsets.all(h(10)),
                            validation: 'name')),
                    SizedBox(
                      height: h(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        text(
                            text: 'Ads about to finish',
                            color: AppColor.darkBlue),
                        container(
                            borderRadius: 5,
                            color: Colors.grey[200],
                            hight: h(50),
                            width: w(50),
                            child: Center(
                                child: textform(
                                    hintColor: AppColor.hintcolor,
                                    hint: AppLocalizations.of(context)
                                        .translate('Time'),
                                    controller: timec,
                                    function: (val) {
                                      time = val;
                                    },
                                    padding: EdgeInsets.all(h(10)),
                                    validation: 'number'))),
                        container(
                            borderRadius: 5,
                            color: Colors.grey[200],
                            hight: h(50),
                            width: w(90),
                            child: DropDown(
                              chosenvalue: timeUnite,
                              getindex: (val) {},
                              onchanged: (val) {
                                timeUnite = val;
                              },
                              list: [
                                AppLocalizations.of(context).translate('Days'),
                                AppLocalizations.of(context).translate('Hours'),
                                AppLocalizations.of(context)
                                    .translate('Minutes')
                              ],
                              hint: AppLocalizations.of(context)
                                  .translate('Days'),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: h(40),
                    ),
                    BlocListener<SearchBloc, SearchState>(
                      listener: (context, state) {
                        if (state is GetSearchState) {
                          searchResponseModel = state.searchResponseModel;
                          nav(
                              context,
                              wi.SearchResult(
                                searchResponseModel: searchResponseModel,
                                searchRequestModel: searchRequestModel,
                              ));
                        }
                      },
                      child: Builder(builder: (context) {
                        return GestureDetector(
                            onTap: () {
                              searchBloc
                                  .add(GetSearchEvent(searchRequestModel));
                            },
                            child: confirmButton(
                                hint: AppLocalizations.of(context)
                                    .translate('Search')));
                      }),
                    )
                  ]),
            ),
          ))),
    );
  }
}
