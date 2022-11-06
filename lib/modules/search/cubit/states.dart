import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/models/search_model/search_model.dart';

abstract class SearchStates {}
class SearchInitialState extends SearchStates{}
class SearchLoadingState extends SearchStates{}
class SearchSuccessState extends SearchStates{
  final SearchModel searchModel;
  SearchSuccessState(this.searchModel);
}
class SearchErrorState extends SearchStates{}
class SearchBackState extends SearchStates{}


