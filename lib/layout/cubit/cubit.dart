import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/models/get_favorites_model/get_favorites_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/models/change_favorites_model/change_favorites_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ChangeFavoritesModel changeFavoritesModel;
  GetFavoritesModel getFavoritesModel;
  LoginModel userModel;
  List<String> user=[];
  HomeModel homeModel;
  List<DataObject> favoritesList=[];
  CategoriesModel categoriesModel;
  ShopCubit(): super(ShopInitialState());
  static ShopCubit get(context)=> BlocProvider.of(context);
  int currentIndex=0;
  Map<int,bool> favorites={};
  List<Widget> screens=[
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeIndex(int index){
  currentIndex=index;
  emit(ShopChangeBottomNavState());
  }
  void getCategories(){
    DioHelper.getData(url: GET_CATEGORIES,token:token ).then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorCategoriesState());
    });
  }
  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME,token:token ).then((value) {
      homeModel=HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((value) {
        favorites.addAll({value.id: value.inFavorites});
      });

      emit(ShopSuccessHomeDataState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorHomeDataState());
    });
  }
  void loadingState(){
    emit(ShopLoadingCategoriesState());
  }
  void changeFavorites(int productId){
    favorites[productId]=!favorites[productId];
    emit(ShopChangeFavoritesState());
    DioHelper.postData(url: FAVORITES, data: {
      'product_id':productId
    },
    token: token,).then((value)  {
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      if(!changeFavoritesModel.status){
        favorites[productId]=!favorites[productId];
      }
      else{
        emit(ShopSuccessGetFavoritesState());
        getFavorites();
      }
    }).catchError((onError){
      favorites[productId]=!favorites[productId];
      emit(ShopErrorChangeFavoritesState());
    });
  }
  void getFavorites(){
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(url: FAVORITES,token:token ).then((value) {
      getFavoritesModel=GetFavoritesModel.fromJson(value.data);
      favoritesList=getFavoritesModel.data.data;
        emit(ShopSuccessGetFavoritesState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }
  void getUserData(){
    emit(ShopLoadingUserDataState());
    DioHelper.getData(url: PROFILE,token:token ).then((value) {
      userModel=LoginModel.fromJson(value.data);
      user.add(userModel.data.name);
      user.add(userModel.data.email);
      user.add(userModel.data.phone);
      emit(ShopSuccessUserDataState(userModel));
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorUserDataState());
    });
  }
  void updateUserData({String name, String email, String phone, String password,}){
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(url: UPDATE_PROFILE,token:token,data: {
      "name":name,
      "phone":phone,
      "email":email,
      "password":password,
    } ).then((value) {
      userModel=LoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserState(userModel));
      showToast(state: ToastStates.SUCCESS,text: userModel.message);
    }).catchError((onError) {
      showToast(state: ToastStates.ERROR,text: userModel.message);
      print(onError.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
  bool isHidden=true;
  IconData suffix=Icons.visibility_off_outlined;
  void changeEyeStatus(){
    isHidden=!isHidden;
    suffix=isHidden?Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(LoginPasswordState());
  }


}