import 'package:shop_app/models/change_favorites_model/change_favorites_model.dart';
import 'package:shop_app/models/login_model/login_model.dart';

abstract class ShopStates{}
class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavState extends ShopStates{}
class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}
class ShopLoadingCategoriesState extends ShopStates{}
class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{}
class ShopSuccessChangeFavoritesState extends ShopStates{
  final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends ShopStates{}
class ShopChangeFavoritesState extends ShopStates{}
class ShopLoadingGetFavoritesState extends ShopStates{}
class ShopSuccessGetFavoritesState extends ShopStates{}
class ShopErrorGetFavoritesState extends ShopStates{}
class ShopLoadingUserDataState extends ShopStates{}
class ShopSuccessUserDataState extends ShopStates{
  final LoginModel loginModel;
  ShopSuccessUserDataState(this.loginModel);
}
class ShopErrorUserDataState extends ShopStates{}
class ShopLoadingUpdateUserState extends ShopStates{}
class ShopSuccessUpdateUserState extends ShopStates{
  final LoginModel loginModel;
  ShopSuccessUpdateUserState(this.loginModel);
}
class ShopErrorUpdateUserState extends ShopStates{}
class LoginPasswordState extends ShopStates{}


