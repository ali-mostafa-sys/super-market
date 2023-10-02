import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:supermarket/core/utils/snakbar_message.dart';
import 'package:supermarket/core/widgets/loading_widget.dart';
import 'package:supermarket/features/add_product/presentation/pages/add_producte_page.dart';
import 'package:supermarket/features/add_product/presentation/widgets/text_form_widget.dart';
import 'package:supermarket/features/products/presentations/blocs/products_bloc.dart';
import 'package:supermarket/features/products/presentations/pages/edit_price_page.dart';
import 'package:supermarket/injection_container.dart' as di;


class ProductsPage extends StatelessWidget {
   ProductsPage({Key? key}) : super(key: key);
  TextEditingController search=TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return
      // BlocProvider(
      //   create: (context)=>di.sl<ProductsBloc>()..add(GetAllProductEvent()),
      // child:
      BlocConsumer<ProductsBloc,ProductsState>(
        listener: (context,state){
          if(state is LoadedDeleteProductState){
            SnackBarMessage().showSnackBar(message: 'تمت إزالة المنتج بنجاح', backgroundColor: Colors.deepPurple, context: context);
            ProductsBloc.get(context).add(GetAllProductEvent());
          }
        },
        builder: (context,state){
          var  bloc=ProductsBloc.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: Container(),

              leadingWidth:w*0 ,
              backgroundColor: Colors.deepPurple,
              title:const Text('Products'),
              actions: [
                Padding(
                  padding:  EdgeInsets.only(top: w*0.05,right: w*0.02),

                    child:Text(" منتج ${bloc.model.length} ",),

                ),
                Padding(
                  padding:  EdgeInsets.all(w*0.02),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>   AddProductPage()),);
                    },
                    child: Icon(Icons.add),
                  ),
                ),


              ],
            ),
            body: state is LoadingGetAllProductState?const LoadingWidget():
            SingleChildScrollView(
              child: Container(
                //color: Colors.deepPurple,

                child: Column(
                  children: [
                    SizedBox(
                      height: h * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.1),
                      child: TextFormFieldWidget(
                          controller: search,
                          textInputType: TextInputType.text,
                          obscureText: false,
                          labelText: 'البحث',
                          validator: (value){
                            if(value!.isEmpty){
                              return 'لا يجب أن تبقى هذه القيمة فارغة';
                            } else{
                              return null;
                            }

                          },
                        onChange: (value){
                            bloc.add(SearchForProductEvent(searchText: value));

                        },


                          ),


                    ),
                    SizedBox(
                      height: h * 0.03,
                    ),

                    RefreshIndicator(
                      onRefresh: ()async{
                        bloc.add(GetAllProductEvent());
                      },
                      child: Container(
                        width: w,
                        height: h*0.75,
                        color: Colors.deepPurple[100],
                        child: ListView.separated(
                            itemBuilder: (context,index){
                              return InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>   EditPricePage(product: bloc.model[index])),);


                                },
                                child: ListTile(
                                  title: Text('${bloc.model[index].name}',
                                    textDirection:TextDirection.rtl ,
                                    style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: w*0.05
                                    ),


                                  ),
                                  subtitle: Text('${bloc.model[index].barcode}',
                                    textDirection:TextDirection.rtl ,
                                  ),
                                  leading: Text('${bloc.model[index].price}',style: TextStyle(color: Colors.black,fontSize: w*0.05,),),
                                  trailing: IconButton(
                                    onPressed: (){
                                      bloc.add(DeleteProductEvent(id: bloc.model[index].id!));
                                    },
                                    icon: state is LoadingDeleteProductState?const LoadingWidget():

                                    Icon(Icons.takeout_dining_outlined,color: Colors.redAccent),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context,index)=>Divider(color: Colors.deepPurple,height: h*0.005,thickness: h*0.002,endIndent: w*0.1,indent:w*0.1 , ),
                            itemCount: bloc.model.length),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      )


   // )
    ;
  }
}


