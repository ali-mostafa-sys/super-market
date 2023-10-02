import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/utils/snakbar_message.dart';
import 'package:supermarket/core/widgets/loading_widget.dart';
import 'package:supermarket/features/add_product/presentation/widgets/button_widget.dart';
import 'package:supermarket/features/add_product/presentation/widgets/text_form_widget.dart';
import 'package:supermarket/features/products/presentations/blocs/edit_price/edit_price_bloc.dart';
import 'package:supermarket/features/products/presentations/blocs/products_bloc.dart';
import 'package:supermarket/features/products/presentations/pages/products_pages.dart';
import 'package:supermarket/injection_container.dart' as di;




class EditPricePage extends StatelessWidget {

   EditPricePage({Key? key,required this.product}) : super(key: key);

  AllProductModel product;
  TextEditingController price=TextEditingController();
   var formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: Container(),
        leadingWidth:0 ,
        title:const Text('Edit Price'),
      ),
      body: BlocProvider(
        create: (context)=>di.sl<EditPriceBloc>(),
        child: BlocConsumer<EditPriceBloc,EditPriceState>(
          listener: (context,state){
            if(state is LoadedEditPriceState){
              SnackBarMessage().showSnackBar(message: 'تم تعديل المنتج بنجاح', backgroundColor: Colors.deepPurple, context: context);
              Navigator.pop(context);
              // Navigator.pushAndRemoveUntil<dynamic>(
              //   context,
              //   MaterialPageRoute<dynamic>(
              //     builder: (BuildContext context) =>const ProductsPage(),
              //   ),
              //       (route) => false,//if you want to disable back feature set to false
              // );
            }
            if(state is ErrorEditPriceState){
              SnackBarMessage().showSnackBar(message: state.error, backgroundColor: Colors.redAccent, context: context);
            }
          },
          builder: (context,state){
            var bloc =EditPriceBloc.get(context);
            return SingleChildScrollView(
              child: Container(
                width: w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: h*0.05,
                    ),
                    Text('${product.name}',style: TextStyle(
                        fontSize: w*0.1,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold
                    ),
                      textDirection:TextDirection.rtl ,
                    ),
                    SizedBox(
                      height: h*0.05,
                    ),
                    Text(' ${product.price}',style: TextStyle(
                        fontSize: w*0.08,
                        color: Colors.deepPurple
                    ),
                      textDirection:TextDirection.rtl ,
                    ),

                    SizedBox(
                      height: h*0.05,
                    ),
                    Text('السعر الجديد',style: TextStyle(
                        fontSize: w*0.08,
                        color: Colors.deepPurple
                    ),
                      textDirection:TextDirection.rtl ,
                    ),
                    SizedBox(
                      height: h*0.05,
                    ),
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: w*0.1),
                              child: TextFormFieldWidget(
                                controller: price,
                                obscureText: false,
                                textInputType:TextInputType.number ,
                                labelText: 'السعر',
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'لا يجب ترك هذا الحقل فارغ';
                                  }else{
                                    return null;
                                  }
                                },


                              ),
                            ),
                            SizedBox(
                              height: h*0.05,
                            ),
                            state is LoadingEditPriceState?const LoadingWidget():
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: w*0.1),
                              child: ButtonTextWidget(
                                  padding: w*0.01,
                                  backgroundColor: Colors.white10,
                                  text: 'تعديل',
                                  textColor: Colors.deepPurple,
                                  textSize: w*0.08,
                                  onPressed: (){
                                    if(formKey.currentState!.validate()){
                                      bloc.add(PutNewPriceEvent(name: product.name!, price: price.text, barcode:product.barcode!, id:product.id!));




                                    }
                                  }),
                            ),


                          ],
                        ))







                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}





