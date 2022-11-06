import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(): super( LoginInitialState());
  static LoginCubit get(context)=> BlocProvider.of(context);
  bool isHidden=true;
  IconData suffix=Icons.visibility_off_outlined;
  void changeEyeStatus(){
   isHidden=!isHidden;
    suffix=isHidden?Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(LoginPasswordState());
  }
  LoginModel loginModel;

  void userLogin({
  @required String email,
    @required String password,
  }){
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
    'password': password,
    },
    ).then((value) {
      loginModel=LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((onError) {
      print('${onError.toString()}');
      emit(LoginErrorState());
    });
  }
}