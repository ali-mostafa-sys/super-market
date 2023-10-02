

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/widgets/loading_widget.dart';
import 'package:supermarket/features/add_product/presentation/widgets/button_widget.dart';
import 'package:supermarket/features/products/presentations/blocs/products_bloc.dart';

class CreateInvoicePage extends StatelessWidget {
  const CreateInvoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return BlocConsumer<ProductsBloc,ProductsState>(
        listener: (context,state){},
      builder: (context,state){
          var bloc=ProductsBloc.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              leading: Container(),
              leadingWidth: 0,
              title:const Text('Create Invoice'),
              actions: [
                Padding(
                  padding:  EdgeInsets.all(w*0.03),
                  child: InkWell(
                    onTap: (){
                      bloc.add(GetAllProductEvent());

                    },
                    child: Icon(Icons.refresh,size: w*0.1,),
                  ),
                )
              ],


            ),
            body:Container(
              width: w,

              height: h,
              child:
              state is LoadingGetAllProductState?const LoadingWidget():
              Container(
                height: h,
                width: w,
                child: Column(
                  children: [

                    SizedBox(
                      height: h * 0.01,
                    ),
                    /// here for new invoice
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: w*0.1),
                      child: ButtonTextWidget(
                          padding: w*0.01,
                          backgroundColor: Colors.white10,
                          text: 'فاتورة جديدة',
                          textColor: Colors.deepPurple,
                          textSize: w*0.08,
                          onPressed: (){

                            bloc.add(NewInvoiceEvent());

                          }),
                    ),
                    SizedBox(
                      height: h * 0.03,
                    ),
                    Container(
                      width: w,
                      height: h*0.5,

                      child: ListView.separated(
                          itemBuilder: (context,index){
                            return ListTile(
                              title: Text('${bloc.invoiceList[index].name}',
                                textDirection:TextDirection.rtl ,
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: w*0.05
                                ),


                              ),
                              subtitle: Text('${bloc.invoiceList[index].barcode}',
                                textDirection:TextDirection.rtl ,
                              ),
                              leading: Text('${bloc.invoiceList[index].price}',style: TextStyle(color: Colors.black,fontSize: w*0.05,),),
                              trailing: IconButton(
                                onPressed: (){

                                  bloc.add(DeleteProductFromInvoiceListEvent(barcode:bloc.invoiceList[index].barcode! ,));
                                },
                                icon: Icon(Icons.takeout_dining_outlined,color: Colors.redAccent),
                              ),
                            );
                          },
                          separatorBuilder: (context,index)=>Divider(color: Colors.deepPurple,height: h*0.005,thickness: h*0.002,endIndent: w*0.1,indent:w*0.1 , ),
                          itemCount: bloc.invoiceList.length),

                    ),



                    SizedBox(
                      height: h * 0.03,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: w*0.1),
                      child: ButtonTextWidget(
                          padding: w*0.01,
                          backgroundColor: Colors.white10,
                          text: 'باركود',
                          textColor: Colors.deepPurple,
                          textSize: w*0.08,
                          onPressed: (){

                            bloc.add(GetBareCodeEvent());

                          }),
                    ),
                    SizedBox(
                      height: h * 0.03,
                    ),
                    bloc.price==null?Container():
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: w*0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [


                          Text('${bloc.price}' ,style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: w*0.09,
                          ),),


                          Text(' :السعر المجمل' ,style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: w*0.05,
                          ),),


                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ),
          );
      },
    );
  }
}





