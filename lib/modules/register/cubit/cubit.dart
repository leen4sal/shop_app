import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit(): super( RegisterInitialState());
  static RegisterCubit get(context)=> BlocProvider.of(context);
  bool isHidden=true;
  IconData suffix=Icons.visibility_off_outlined;
  void changeEyeStatus(){
   isHidden=!isHidden;
    suffix=isHidden?Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(RegisterPasswordState());
  }
  LoginModel loginModel;

  void userRegister({
  @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }){
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
    'password': password,
      'phone': phone,
    },
    ).then((value) {
      loginModel=LoginModel.fromJson(value.data);
      print('done');
      print(loginModel.message);
      emit(RegisterSuccessState(loginModel));
    }).catchError((onError) {
      print('${onError.toString()}');
      emit(RegisterErrorState());
    });
  }
}