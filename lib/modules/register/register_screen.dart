import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/style/colors.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';
class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    bool isObsecure = true;
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController phone = TextEditingController();
    var cubit=RegisterCubit.get(context);
    return BlocConsumer<RegisterCubit,RegisterStates>(
      builder:(context, state) {
        return Scaffold(body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Register',
                      style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.black,fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Register now to browse our hot offers',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      type: TextInputType.text,
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                      validation: (value) {
                        if (value.isEmpty) {
                          return 'this field is required';
                        }
                        return null;
                      },
                      controller: name,
                      label: 'User Name',
                      icon: Icons.person_outline,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    defaultFormField(
                      type: TextInputType.emailAddress,
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                      validation: (value) {
                        if (value.isEmpty) {
                          return 'this field is required';
                        }
                        return null;
                      },
                      controller: email,
                      label: 'Email Address',
                      icon: Icons.email_outlined,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    defaultFormField(
                        type: TextInputType.visiblePassword,
                        onFieldSubmitted: (value) {
                          if (formkey.currentState.validate()) {
                            cubit.userRegister(email: email.text,name: name.text,phone: phone.text, password: password.text);
                          }
                        },
                        validation: (value) {
                          if (value.isEmpty) {
                            return 'password is too short';
                          }
                          return null;
                        },
                        controller: password,
                        label: 'Password',
                        icon: Icons.lock_outline_rounded,
                        isObs: cubit.isHidden? true:false,
                        myButton: GestureDetector(
                            child: Icon(cubit.suffix ),
                            onLongPress: () {
                              cubit.changeEyeStatus();
                            },
                            onLongPressUp: () {
                              cubit.changeEyeStatus();
                            })),
                    SizedBox(
                      height: 5.0,
                    ),
                    defaultFormField(
                      type: TextInputType.phone,
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                      validation: (value) {
                        if (value.isEmpty) {
                          return 'this field is required';
                        }
                        return null;
                      },
                      controller: phone,
                      label: 'Phone',
                      icon: Icons.phone_enabled_outlined,
                    ),
                    SizedBox(
                      height: 80.0,
                    ),
                    ConditionalBuilder(condition:state is ! RegisterLoadingState ,
                      builder: (context) =>  defaultButton(color: primaryColor,radiusTR:5 ,radiusBL: 5,radiusBR: 5,radiusTL:5 ,
                        height: 50.0,
                        text: 'Register',
                        isUpper: true,
                        onPress: () {
                          if (formkey.currentState.validate()) {
                            cubit.userRegister(email: email.text,name: name.text,phone: phone.text, password: password.text);
                          }
                        },
                      ),
                      fallback: (context) => Center(child: CircularProgressIndicator()),),
                  ],
                ),
              ),
            ),
          ),
        ) );
      } ,
      listener: (context, state) {
        if(state is RegisterSuccessState){
          if(state.loginModel.status){
            CacheHelper.saveData(key: 'token', value:state.loginModel.data.token ).then((value)
            {
              token=state.loginModel.data.token;
              navigateAndFinish(context, HomeLayout());});
            showToast(text: state.loginModel.message,state: ToastStates.SUCCESS);
          }
          else{
            showToast(text: state.loginModel.message,state: ToastStates.ERROR);
          }
        }
      },
    );
  }
}
