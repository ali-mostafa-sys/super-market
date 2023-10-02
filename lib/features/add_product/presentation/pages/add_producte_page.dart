import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:supermarket/core/utils/snakbar_message.dart';
import 'package:supermarket/core/widgets/loading_widget.dart';
//import 'package:scan/scan.dart';
import 'package:supermarket/features/add_product/presentation/blocs/add_product_bloc.dart';
import 'package:supermarket/features/add_product/presentation/widgets/button_widget.dart';
import 'package:supermarket/features/add_product/presentation/widgets/text_form_widget.dart';
import 'package:supermarket/features/products/presentations/pages/products_pages.dart';
import 'package:supermarket/injection_container.dart' as di;

class AddProductPage extends StatelessWidget {
  AddProductPage({Key? key}) : super(key: key);
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  var formKey = GlobalKey<FormState>();
 // ScanController controller = ScanController();
  String qrcode = 'Unknown';

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: w * 0,
        leading: Container(),
        backgroundColor: Colors.deepPurple,
        title: const Text('Add Product'),
      ),
      body:
      BlocProvider(
        create: (context)=>di.sl<AddProductBloc>(),
        child: BlocConsumer<AddProductBloc,AddProductState>
          (
          listener: (context,state){
            if(state is LoadedAddProductState){
              SnackBarMessage().showSnackBar(message: 'تمت إضافة المنتج بنجاح', backgroundColor: Colors.deepPurple, context: context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) =>   ProductsPage()),);
              Navigator.pop(context);


            }
            if(state is ErrorAddProductState){
              SnackBarMessage().showSnackBar(message: state.error, backgroundColor: Colors.redAccent, context: context);

            }
          },
          builder: (context,state){
            var bloc=AddProductBloc.get(context);
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: h * 0.03,
                    ),
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: w * 0.1),
                              child: TextFormFieldWidget(
                                  controller: name,
                                  textInputType: TextInputType.text,
                                  obscureText: false,
                                  labelText: 'اسم المنتج',
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'لا يجب أن تبقى هذه القيمة فارغة';
                                    } else{
                                      return null;
                                    }

                                  }),
                            ),
                            SizedBox(
                              height: h * 0.03,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: w * 0.1),
                              child: TextFormFieldWidget(
                                  controller: price,
                                  textInputType: TextInputType.number,
                                  obscureText: false,
                                  labelText: 'السعر',
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'لا يجب أن تبقى هذه القيمة فارغة';
                                    } else{
                                      return null;
                                    }

                                  }),
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

                                    bloc.add(BareCodeEvent());

                                  }),
                            ),
                            SizedBox(
                              height: h * 0.03,
                            ),

                            bloc.barcodeScanRes==null?Container():

                            Text(
                              bloc.barcodeScanRes!,
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: w*0.08
                              ),
                            ),


                            SizedBox(
                              height: h * 0.03,
                            ),
                            state is LoadingAddProductState?const  LoadingWidget():
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: w*0.1),
                              child: ButtonTextWidget(
                                  padding: w*0.01,
                                  backgroundColor: Colors.white10,
                                  text: 'إضافة',
                                  textColor: Colors.deepPurple,
                                  textSize: w*0.08,
                                  onPressed: (){
                                    if(formKey.currentState!.validate()){
                                      if(bloc.barcodeScanRes!=null){


                                        bloc.add(AddProductForDataBaseEvent(name: name.text, price: price.text,
                                            barcode:bloc.barcodeScanRes!
                                        )
                                        );

                                      }else{
                                        SnackBarMessage().showSnackBar(message: 'يجب أخذ البار كود الخاص بالمنتج', backgroundColor: Colors.redAccent, context: context);

                                      }
                                    }
                                  }),
                            ),




                          ],
                        )),
                    SizedBox(
                      height: h * 0.03,
                    ),




//                   Container(
//                     width: 250, // custom wrap size
//                     height: 250,
//                     child: ScanView(
//                       controller: controller,
// // custom scan area, if set to 1.0, will scan full area
//                       scanAreaScale: .7,
//                       scanLineColor: Colors.green.shade400,
//                       onCapture: (data) {
//                         print(data);
//                       },
//                     ),
//                   ),


                  ],
                ),
              ),
            );
          },

        ),
      )
      ,
    );
  }
}

// MobileScanner(
// // fit: BoxFit.contain,
// onDetect: (capture) {
// final List<Barcode> barcodes = capture.barcodes;
// final Uint8List? image = capture.image;
// for (final barcode in barcodes) {
// debugPrint('Barcode found! ${barcode.rawValue}');
// }
// },
// ),

