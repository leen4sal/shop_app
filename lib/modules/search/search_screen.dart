import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController=TextEditingController();
  var searchKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        builder: (context, state) {
          var cubit=SearchCubit.get(context);
          return  SafeArea(
            child: Scaffold(appBar: AppBar(),
                body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all( 10),
                  child: Form(key: searchKey,
                      child: Column(
                        children: [
                          defaultFormField(controller: searchController,onChange: (value){
                            SearchCubit.get(context).searchItem(text: value);

                          } ,validation: (String value){
                            if (value.isEmpty)
                              return 'enter a word';
                            else return null;
                          },
                          icon: Icons.search,
                          label: "search",
                     radius: 10,
                          type: TextInputType.text,
                          onFieldSubmitted: (String value){
                            SearchCubit.get(context).searchItem(text: value);
                          }),
                          SizedBox(height: 20,),
                          if(state is SearchLoadingState)
                            LinearProgressIndicator(),
                        ],
                      ),
                  ),
                ),
                  Expanded(
                    child: ConditionalBuilder(
                      condition: cubit.saerchList.length>0,
                      builder: (context) {
                        return  ListView.separated(
                          itemBuilder: (context, index) {
                            return buildFavItem(
                                model: cubit.saerchList[index],
                                context: context,
                                index: index,
                                isDiscount: false);
                          },
                          separatorBuilder: (context, index) {
                            return myDivider(height: 5);
                          },
                          itemCount: cubit.saerchList.length,
                          physics: BouncingScrollPhysics(),
                        );
                      },
                      fallback: (context) {
                        return Center(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column( mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Nothing to show',style: TextStyle(fontWeight:FontWeight.w500 ,color: Colors.grey,fontSize: 20),),
                              Text('Write a word to search for',style: TextStyle(fontWeight:FontWeight.w500 ,color: Colors.grey,fontSize: 20),),
                              SizedBox(height: 5,),
                              Icon(Icons.search,color: Colors.grey,size: 35,),
                            ],
                          ),
                        ));
                      },
                    ),
                  )
              ],
            )),
          );
        },
        listener: (context, state) {

        },
      ),
    );
  }
}
