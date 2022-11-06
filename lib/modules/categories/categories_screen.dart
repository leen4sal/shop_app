import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:shop_app/shared/style/colors.dart';
import 'package:progress_indicators/progress_indicators.dart';



class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
    builder: (context, state) {
      var cubit=ShopCubit.get(context);
      return ConditionalBuilder(condition:  cubit.categoriesModel!=null,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ListView.separated(itemBuilder: (context, index) {
                return buildCategoryItem(cubit.categoriesModel.data.data[index]);
              }, separatorBuilder: (context, index) {
                return myDivider(height: 5);
              }, itemCount: cubit.categoriesModel.data.data.length,physics: BouncingScrollPhysics(),),
            ) ;
          },fallback: (context) { cubit.loadingState();
            return myIndicator();}
        );
      },
      listener: (context, state) {
      },
    );
  }
}


Widget buildCategoryItem(DataObjectC model){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Row(
      children: [
        Container(decoration: categoryDecoration(radius: 5,borderColor: Colors.grey,),clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image(image: NetworkImage(model.image,),width: 110,height: 110,fit: BoxFit.cover,)),
        SizedBox(width: 10,),
        Text(model.name.capitalize(),style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold, ),maxLines: 1,overflow: TextOverflow.ellipsis,),
        Spacer(),
        IconButton(icon: Icon(Icons.arrow_forward_ios_outlined,color: primaryColor),),
      ],
    ),
  );
}