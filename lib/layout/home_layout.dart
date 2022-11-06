import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/search_screen.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit=ShopCubit.get(context);
        return Scaffold(appBar: AppBar(title: Text('Triviewo'),centerTitle: true,elevation: 0,
          actions: [
          IconButton(icon: Icon(Icons.search),onPressed: () {
            SearchCubit.get(context).back();
            navigateTo(context, SearchScreen());
          },)
        ],),
          body: cubit.screens[cubit.currentIndex]
          ,bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
          ],
          currentIndex: cubit.currentIndex,
            onTap: ( index){
            cubit.changeIndex(index);
            },
        ) ,
        );
      },
    );
  }
}
