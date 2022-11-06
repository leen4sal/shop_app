import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/bloc_observe.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/status.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/style/themes.dart';
import 'modules/register/cubit/cubit.dart';
import 'modules/search/cubit/cubit.dart';


void main() async {
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
   DioHelper.init();
  await CacheHelper.init();
   token = CacheHelper.getData(key: 'token');
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  Widget widget;
  if (onBoarding != null) {
    if (token != null) {
      widget = HomeLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    token: token,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  String token;
  Widget startWidget;
  MyApp({this.token, this.startWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) =>LoginCubit() ),
          BlocProvider(create: (context) =>RegisterCubit() ),
          BlocProvider(create:(context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData() ),
          BlocProvider(create: (context) =>SearchCubit() ),
          BlocProvider(create: (context) =>AppCubit() ),
        ],
        child: BlocProvider( create: (context) => AppCubit(),
          child: BlocConsumer<AppCubit, AppStates>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: lightTheme,
                home: startWidget,
              );
            },
            listener: (context, state) {},
          ),
        ));
  }
}
