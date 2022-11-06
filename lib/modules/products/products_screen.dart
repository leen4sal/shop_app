import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/style/colors.dart';
import 'package:string_extensions/string_extensions.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Center(
            child: ConditionalBuilder(
          condition:
              (cubit.homeModel != null) && (cubit.categoriesModel != null),
          builder: (context) => Column(
            children: [
              buildProductsScreen(cubit.homeModel, cubit.categoriesModel, context),
            ],
          ),
          fallback: (context) =>   myIndicator()
        ));
      },
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoritesState) {
          if(!state.model.status){
            showToast(state: ToastStates.ERROR,text: state.model.message);
          }else{
            showToast(state: ToastStates.SUCCESS,text: state.model.message);
          }
        }
      },
    );
  }
}

Widget buildProductsScreen(
    HomeModel homeModel, CategoriesModel categoryModel, context) {
  return Expanded(
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
              items: homeModel.data.banners
                  .map((element) => Image(
                        image: NetworkImage('${element.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayInterval: Duration(
                  seconds: 3,
                ),
                initialPage: 0,
                autoPlayAnimationDuration: Duration(seconds: 1),
                viewportFraction: 1.0,
                scrollDirection: Axis.horizontal,
                reverse: false,
                enableInfiniteScroll: true,
              )),
          SizedBox(
            height: 1,
          ),
          // Text(
          //   'Categories',
          //   style: TextStyle(fontWeight: FontWeight.w600),
          // ),
          // SizedBox(
          //   height: 1,
          // ),
          // Container(
          //   height: 112,
          //   child: ListView.separated(
          //       physics: BouncingScrollPhysics(),
          //       scrollDirection: Axis.horizontal,
          //       itemBuilder: (context, index) {
          //         return buildCategoryItem(categoryModel.data.data[index]);
          //       },
          //       separatorBuilder: (context, index) {
          //         return myDivider(width: 5);
          //       },
          //       itemCount: categoryModel.data.data.length),
          // ),
          SizedBox(
            height: 3,
          ),
          Text('New Products', style: TextStyle(fontWeight: FontWeight.w600)),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.2,
                children: List.generate(
                    homeModel.data.products.length,
                    (index) => buildGridItem(
                        homeModel.data.products[index], context))),
          )
        ],
      ),
    ),
  );
}

Widget buildGridItem(ProductModel model, context) {
  return Container(
    color: Colors.white,
    child: Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Image(
                  image: NetworkImage(
                    '${model.image}',
                  ),
                  height: 150,
                  width: 160,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                        width: 170,
                        height: 35,
                        child: Text(
                          '${model.name}',
                          style: TextStyle(fontSize: 11, height: 1.5),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                    SizedBox(
                      width: 170,
                      height: 25,
                      child: Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${model.price}',
                                style: TextStyle(
                                    fontSize: 12,
                                    height: 1.5,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              if (model.discount != 0)
                                Text(
                                  '${model.oldPrice}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      height: 1.5,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                      decorationThickness: 2,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
                          Container(
                            width: 25,
                            height: 20,
                            child: IconButton(
                                padding: EdgeInsets.zero,
                                iconSize: 19,
                                onPressed: () {
                                  ShopCubit.get(context).changeFavorites(model.id);
                                },
                                icon: ShopCubit.get(context).favorites[model.id]
                                    ? Icon(
                                        Icons.favorite,
                                        color: primaryColor,
                                      ):Icon(
                                  Icons.favorite_border,
                                  color: Colors.grey,
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (model.discount != 0)
          Padding(
            padding: const EdgeInsets.only(top: 1, left: 1),
            child: Container(
              color: Colors.red,
              height: 13,
              width: 48,
              child: Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(
                  'DISCOUNT!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

Widget buildCategoryItem(DataObjectC model) {
  return Container(
    width: 110,
    height: 110,
    decoration:
        categoryDecoration(radius: 10, borderWidth: 1, borderColor: Colors.grey[400]),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
      Container(
          width: 110,
          height: 110,
          decoration: categoryDecoration(),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image(
              image: NetworkImage('${model.image}'), width: 110, height: 110)),
      //image: NetworkImage('${model.image}'),width: 110,height:
      //image: CachedNetworkImageProvider('${model.image}',maxHeight: 110,maxWidth: 110,scale: 1)
      Container(
        decoration: BoxDecoration(
          borderRadius: categoryBorder(),
          color: primaryColor.withOpacity(0.7),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Text(
            '${model.name.toUpperCase()}'.capitalize(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              letterSpacing: 1,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        width: 110,
        height: 25,
      )
    ]),
  );
}
