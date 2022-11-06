import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit(): super( SearchInitialState());
  static SearchCubit get(context)=> BlocProvider.of(context);
  SearchModel searchModel;
  List<DataObject> saerchList=[];

  void searchItem({
  @required String text,
  }){
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, data: {
      'text': text,
    },
      token: token,
    ).then((value) {
      searchModel=SearchModel.fromJson(value.data);
      saerchList=searchModel.data.data;
      emit(SearchSuccessState(searchModel));
    }).catchError((onError) {
      print('${onError.toString()}');
      emit(SearchErrorState());
    });
  }
  void back(){
    saerchList.clear();
    emit(SearchBackState());
  }
}