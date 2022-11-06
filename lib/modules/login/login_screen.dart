import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/style/colors.dart';
import '../../shared/components/components.dart';


class LoginScreen extends StatelessWidget{

  var formkey = GlobalKey<FormState>();
  bool isObsecure = true;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit,LoginStates>(
      builder: (context, state) {
        var cubit=LoginCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.black,fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Login now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 20.0,
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
                              cubit.userLogin(email: email.text, password: pass.text);
                            }
                          },
                          validation: (value) {
                            if (value.isEmpty) {
                              return 'password is too short';
                            }
                            return null;
                          },
                          controller: pass,
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
                        height: 150.0,
                      ),
                     ConditionalBuilder(condition:state is! LoginLoadingState ,
                       builder: (context) =>  defaultButton(color: primaryColor,radiusTR:5 ,radiusBL: 5,radiusBR: 5,radiusTL:5 ,
                         height: 50.0,
                         text: 'Login',
                         isUpper: true,
                         onPress: () {
                           if (formkey.currentState.validate()) {
                             cubit.userLogin(email: email.text, password: pass.text);
                           }
                         },
                       ),
                       fallback: (context) => Center(child: CircularProgressIndicator()),),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text('Don\'t have an account?',style: TextStyle(),),
                        defaultTextButton(onPressed: () {
                          navigateAndFinish(context, RegisterScreen());
                        },
                          text: 'register',),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
       if(state is LoginSuccessState){
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
