import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';




import 'package:toast/toast.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/App/app_localizations.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/custom_list_view.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/features/Register/presentation/widgets/input_drop.dart';
import 'package:tradpool/features/add_auction/data/models/brands_for_sub_category.dart';
import 'package:tradpool/features/add_auction/data/models/main_category.dart';
import 'package:tradpool/features/add_auction/data/models/sub_category.dart';
import 'package:tradpool/features/add_auction/presentation/bloc/add_item_bloc.dart';
import 'package:tradpool/features/add_auction/presentation/widgets/loading.dart';
import 'package:tradpool/features/settings/data/model/preferences_body_model.dart';
import 'package:tradpool/features/settings/presentation/bloc/settings_bloc.dart';

import '../../../../injection_container.dart';

class AddUserPreferences extends StatefulWidget {
  const AddUserPreferences({Key key}) : super(key: key);

  @override
  _AddUserPreferencesState createState() => _AddUserPreferencesState();
}

class _AddUserPreferencesState extends State<AddUserPreferences> {
  List<PreferencesBodyRequestModel>  userPreferences =[];
  SettingsBloc settingsBloc = sl<SettingsBloc>();
  List<Datum> preferencesData =[];
  List<BrandsForSubCategoryModel> brands = [];
  List<MainCategories> mainCategory = [];
  List<SubCategories> subcategory = [];
  List<BrandsForSubCategoryModel> chosenbrands = [];
  // ignore: prefer_typing_uninitialized_variables
  var chosenMainCategory;
  // ignore: prefer_typing_uninitialized_variables
  var chosenSubCategory;


  String category;
  String subCategory;
  String brand;
  String status;
  String mainCategoryId;
  String subCategoryId;
  List<MultiSelectItem<BrandsForSubCategoryModel>> brandsForSub = [];

  String brandId;
  AddItemBloc addItemBloc = sl<AddItemBloc>();

  @override
  void initState() {
    addItemBloc.add(GetMainCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(shrinkWrap: true, children: [
      SizedBox(
        height: h(40),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          container(
            hight: h(36),
            width: w(36),
            color: Colors.white,
            child: const Center(
                child: Icon(
              Icons.menu,
              color: Colors.black,
              size: 30,
            )),
          ),
          SvgPicture.asset(
            "assets/images/logo.svg",
            fit: BoxFit.contain,
          ),
          container(
            color: Colors.white,
            child: SvgPicture.asset(
              'assets/images/search.svg',
              height: h(25),
              width: w(25),
            ),
          )
        ],
      ),
      SizedBox(
        height: h(50),
      ),

      Row(
        children: [
          SizedBox(
              width: w(150),
              child: Center(
                  child: text(
                      text: 'preferences',
                      color: AppColor.blue,
                      fontsize: 18.sp))),
        ],
      ),
      SizedBox(
        height: h(20),
      ),
      BlocBuilder(
          bloc: addItemBloc,
          builder: (context, state) {
            if (state is Loading) {
              return const Center(child: LoadingState());
            }
            if (state is GetMainCategoriesState) {
              mainCategory = state.mainCategories;
              addItemBloc.add(GetSubCategoriesEvent(mainCategoryId));
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: w(20)),
              child: IgnorePointer(
                ignoring: (state is Loading),
                child: inputDrop(
                    width: w(330),
                    chosenvalue: category,
                    hint: AppLocalizations.of(context).translate( "Select Category"),
                    list: mainCategory,
                    value: (value) {
                      chosenMainCategory = value;
                      mainCategoryId = value.id;
                      category = value.name;

                      addItemBloc
                          .add(GetSubCategoriesEvent(value.id.toString()));
                    }),
              ),
            );
          }),
      SizedBox(
        height: h(17),
      ),
      BlocBuilder(
        bloc: addItemBloc,
        builder: (context, state) {
          if (state is LoadingSubCategory) {
            return const Center(child: LoadingState());
          }
          if (state is GetSubCategoriesState) {
            log('here from getsub');
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
                    chosenSubCategory = value;
                    subCategory = value.name;
                    subCategoryId = value.id;
                    brands = [];
                    log(subCategoryId);
                    addItemBloc.add(
                        GetBrandsForSubCategoriesEvent(value.id.toString()));
                  }),
              SizedBox(
                height: h(17),
              ),
            ],
          );
        },
      ),

      BlocBuilder(
          bloc: addItemBloc,
          builder: (context, state) {
            if (state is GetBransForSubCategoryState) {
              log('here from the brands state');
          
              brands =state.brands;
         
            }
            // if (state is Error){
            //   return text(text: 'error');
            // }
            if (state is LoadingBrand) {
             
              return const Center(
                child: LoadingState(),
              );
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: w(20)),
              child: customlistview(padding: 1,
                hight: h(60),itemcount: brands.length ,width: w(350),scroll: true,
                controller: ScrollController(),direction: "horizontal",function: (context,index){
                return 
                  
                  GestureDetector(onTap: (){
                    if (chosenbrands.contains(brands[index])){

                    }
                    else {
                    chosenbrands.add(brands[index]);
                    setState(() {
                      
                    });}
                  },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: container(borderRadius: 20,hight: h(40),width: w(90),color: Colors.grey,
                        child: text(text: brands[index].name,color: Colors.white,fontsize: 10.sp)),
                    ),
                  );
              }
              ),
          
              
            );
          }),
          SizedBox(height: h(20),),

                Row(
        children: [
          SizedBox(
              width: w(200),
              child: Center(
                  child: text(
                      text: 'chosen preferences',
                      color: AppColor.blue,
                      fontsize: 18.sp))),
        ],
      ),
      SizedBox(height: h(20),),

          customlistview(hight: h(70),
          width: w(350),
            controller: ScrollController(),direction: "horizontal",itemcount: chosenbrands.length,scroll: true,padding: 1,function: (context,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
           
                  
                  container(borderRadius: 20,hight: h(40),width: w(90),color: AppColor.blue,
                    child: text(text: chosenbrands[index].name,color: Colors.white,fontsize: 10.sp)),

                           GestureDetector(
                             onTap: (){
                               chosenbrands.removeAt(index);
                               setState(() {
                                 
                               });
                             },
                             child: const Icon(Icons.close,color: Colors.white,size: 20,)),
                ],
              ),
            );
          }),


      GestureDetector(
        onTap: () {
          preferencesData.add(Datum(brands: chosenbrands,subCategory: SubCategories(id: subCategoryId)));
          userPreferences.add(PreferencesBodyRequestModel(mainCategory: MainCategories(id: mainCategoryId),data: preferencesData));
 
          PreferencesBodyRequestModel preferencesBodyRequestModel =
              PreferencesBodyRequestModel(
                  mainCategory: chosenMainCategory,
                  data: [
                Datum(subCategory: chosenSubCategory, brands: chosenbrands)
              ]);


          settingsBloc
              .add(FillUserPreferencesEvent([preferencesBodyRequestModel]));
        },
        child: BlocConsumer(
          bloc: settingsBloc,
          listener: (context, state) {
            if (state is PreferencesState){
              Toast.show(AppLocalizations.of(context).translate( "Addedd Successfully"), context);
            }
           
          },
          builder: (context, state) {
            if (state is LoadingPreferences){
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(40.0),
              child: container(
                  color: AppColor.blue,
                  width: w(200),
                  hight: h(50),
                  child: text(text: 'submit', color: Colors.white),
                  borderRadius: 5),
            );
          },
        ),
      )

      //     );  })]
    ])));
  }
}
