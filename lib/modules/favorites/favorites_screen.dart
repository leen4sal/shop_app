import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      builder: (context, state) {
        var cubit=ShopCubit.get(context);
        return ConditionalBuilder(condition: cubit.favoritesList.length>0,
          builder:(context) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return buildFavItem(
                        model: cubit.getFavoritesModel.data.data[index].product,
                    context: context,
                    index: index);
                  },
                  separatorBuilder: (context, index) {
                    return myDivider(height: 5);
                  },
                  itemCount: cubit.getFavoritesModel.data.data.length,
                  physics: BouncingScrollPhysics(),
                ),
              );
          },
          fallback: (context) {
            return Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column( mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Nothing to show',style: TextStyle(fontWeight:FontWeight.w500 ,color: Colors.grey,fontSize: 20),),
                  Text('Add some products to favorites',style: TextStyle(fontWeight:FontWeight.w500 ,color: Colors.grey,fontSize: 20),),
                  ],
              ),
            ));
          },
        );
      },
      listener: (context, state) {
      },
    );
  }
}



