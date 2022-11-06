import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/models/get_favorites_model/get_favorites_model.dart';
import 'package:shop_app/shared/style/colors.dart';

Widget defaultButton(
    {@required double height,
      double width = double.infinity,
      bool isUpper = true,
      @required String text,
      @required Function onPress,
      double radiusTL=0,
      double radiusTR=0,
      double radiusBL=0,
      double radiusBR=0,
      Color color }) =>
    Container(
        height: height,
        width: width,
        child: MaterialButton(shape: RoundedRectangleBorder(borderRadius:  BorderRadius.only(topLeft: Radius.circular(radiusTL),bottomRight: Radius.circular(radiusBR) ,bottomLeft:  Radius.circular(radiusBL),topRight: Radius.circular(radiusTR) ) ),
          onPressed: onPress,
          child: Text(
            isUpper ? text.toUpperCase() : text,
            style: TextStyle(color: Colors.white),
          ),
          color: color,
        ));


Widget defaultTextButton({@required Function onPressed, @required String text,Color color=Colors.green}){
  return TextButton(onPressed:onPressed, child: Text(text.toUpperCase(),style: TextStyle(color: color,),));
}

Widget defaultFormField(
    {@required TextEditingController controller,
      bool isObs = false,
       TextInputType type,
      @required Function validation,
       Function onFieldSubmitted,
       Function onChange,
      String label,
      Function onTap,
      double radius = 5.0,
      IconData icon,
      Widget myButton,
      }) =>
    TextFormField(
      obscureText: isObs,
      keyboardType: type,
      onTap: onTap,
      onChanged: onChange,
      onFieldSubmitted: onFieldSubmitted,
      validator: validation,
      controller: controller,
      decoration: InputDecoration(
          suffixIcon: myButton,
          hintText: label,hintStyle: TextStyle(fontFamily: 'Caveat',),
          prefixIcon: Icon(icon,),
          border: OutlineInputBorder(
              borderSide: BorderSide( width: 0.1),
              borderRadius: BorderRadius.only( bottomLeft:  Radius.circular(radius), bottomRight:  Radius.circular(radius),
                  topLeft: Radius.circular(radius),
                  topRight: Radius.circular(radius)))),
    );
void showToast({String text,ToastStates state}){
   Fluttertoast.showToast(
      msg: "$text",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: chooseToastColor(state: state),
      textColor: Colors.white,
      fontSize: 13.0
  );
}
enum ToastStates{ERROR,WARNING, SUCCESS  }
Color chooseToastColor({ToastStates state}){
  Color color;
  switch (state) {
    case  ToastStates.ERROR:
      color=Colors.red;
      break;
    case  ToastStates.WARNING:
      color=Colors.amber;
      break;
    case  ToastStates.SUCCESS:
      color=Colors.green;
      break;
  }
  return color;
}
BorderRadiusGeometry categoryBorder({double radius=5}){
  return BorderRadius.only(bottomLeft: Radius.circular(radius),bottomRight: Radius.circular(radius));
}
Decoration categoryDecoration({double radius=10,double borderWidth=0 ,Color borderColor=Colors.transparent,Color containerColor=Colors.transparent}){
  return BoxDecoration(color: containerColor,
      borderRadius: BorderRadius.all(Radius.circular(radius),),
      border: Border.all(width: borderWidth,color: borderColor ));
}
Widget myDivider({double height=0,double width = 0}){
  return  SizedBox(height:height,width: width,);
}
Widget myIndicator(){
  return Center(
    child: Column(mainAxisSize: MainAxisSize.min,
      children: [
        GlowingProgressIndicator(
            child: Icon(
              Icons.store,
              color: Colors.grey,
              size: 60.0,
            )),
        SizedBox(height: 10,),
        ScalingText('...',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w900,fontSize: 26,),),
      ],
    ),
  );
}
Widget buildFavItem({ model, int index, context,bool isDiscount=true}){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Container(height: 110,
      child: Row(
        children: [
          Container( height:110 ,width: 110,decoration: categoryDecoration(radius: 5,containerColor:Colors.white,borderColor: Colors.grey,),clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Image(
                    image: NetworkImage(
                      '${model.image}',
                    ),
                    height: 108,
                    width: 108,
                  ),
                ),
                if ( isDiscount && model.discount != 0 )
                  Padding(
                    padding: const EdgeInsets.only(top: 1, left: 1),
                    child: Container( decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.only(topLeft: Radius.circular(5)),),clipBehavior: Clip.antiAliasWithSaveLayer,
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
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${model.name}',
                    style: TextStyle(fontSize: 14,),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Spacer(),
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
                    SizedBox(width: 5,),
                    if ( isDiscount && model.discount != 0)
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
                    Spacer(),
                    IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 19,
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon:
                        ShopCubit.get(context).favorites[model.id]
                            ? Icon(
                          Icons.favorite,
                          color: primaryColor,
                        ):Icon(
                          Icons.favorite_border,
                          color: Colors.grey,
                        )
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}