import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/style/colors.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var settingFormkey = GlobalKey<FormState>();
    var cubit = ShopCubit.get(context);
    nameController.text=cubit.userModel.data.name ;
    emailController.text=cubit.userModel.data.email;
    phoneController.text=cubit.userModel.data.phone;
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        return ConditionalBuilder(condition: cubit.userModel!=null ,
          builder: (context) {
           return Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10),
             child: SingleChildScrollView(
               child: Form(
                 key: settingFormkey,
                 child: Column(
                   children: [
                     if(state is ShopLoadingUpdateUserState)
                     LinearProgressIndicator(),
                     SizedBox(height: 10,),
                     defaultFormField(
                       controller: nameController,
                       type: TextInputType.text,
                       validation: (value) {
                         if (value.isEmpty) {
                           return 'enter your name';
                         }
                         return null;
                       },
                       label: 'User Name',
                       icon: Icons.person_outline,
                     ),
                     SizedBox(
                       height: 5,
                     ),
                     defaultFormField(
                       controller: emailController,
                       type: TextInputType.emailAddress,
                       validation: (value) {
                         if (value.isEmpty) {
                           return 'enter your email';
                         }
                         return null;
                       },
                       label: 'Email Address',
                       icon: Icons.email_outlined,
                     ),
                     SizedBox(
                       height: 5,
                     ),
                     defaultFormField(
                         controller: passwordController,
                         type: TextInputType.visiblePassword,
                         validation: (value) {
                           if (value.isEmpty) {
                             return 'enter your password';
                           }
                           return null;
                         },
                         label: 'Password',
                         icon: Icons.lock_outline_rounded,
                         isObs: cubit.isHidden ? true : false,
                         myButton: GestureDetector(
                             child: Icon(cubit.suffix),
                             onLongPress: () {
                               cubit.changeEyeStatus();
                             },
                             onLongPressUp: () {
                               cubit.changeEyeStatus();
                             })),
                     SizedBox(
                       height: 5,
                     ),
                     defaultFormField(
                       controller: phoneController,
                       type: TextInputType.phone, onFieldSubmitted: (value){
                       if(settingFormkey.currentState.validate()){
                         cubit.updateUserData(email: emailController.text,name: nameController.text,password:passwordController.text ,phone:phoneController.text );
                       }
                     },
                       validation: (value) {
                         if (value.isEmpty) {
                           return 'enter your name';
                         }
                         return null;
                       },
                       label: 'Phone',
                       icon: Icons.phone_enabled_outlined,
                     ),
                     SizedBox(height: 55),
                     defaultButton(radiusTL: 5,radiusTR: 5,
                         height: 50.0,
                         onPress: () {
                           signOut(context);
                         },
                         text: 'Sign out',
                         isUpper: true,
                         color: primaryColor),
                     SizedBox(
                       height: 5.0,
                     ),
                     defaultButton(radiusBR: 5,radiusBL: 5,
                         height: 50.0,
                         onPress: () {
                           if(settingFormkey.currentState.validate()){
                             cubit.updateUserData(email: emailController.text,name: nameController.text,password:passwordController.text ,phone:phoneController.text );
                           }
                         },
                         text: 'update profile',
                         isUpper: true,
                         color: primaryColor)
                   ],
                 ),
               ),
             ),
           );
          },
          fallback: (context) => myIndicator(),
        );
      },
      listener: (context, state) {

      },
    );
  }
}
