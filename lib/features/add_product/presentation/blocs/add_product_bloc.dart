import 'dart:async';
// import 'dart:html';


import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  static AddProductBloc get(context)=>BlocProvider.of(context);
  String? barcodeScanRes;
 var db = FirebaseFirestore.instance;



  AddProductBloc() : super(AddProductInitial()) {

    on<AddProductEvent>((event, emit)async {
      ///
      /// here for scan barcode event
      ///

      if(event is BareCodeEvent){
        String barcodeScanRes1='';

        emit(BareCodeFirstState());

        try{
           barcodeScanRes1 = await FlutterBarcodeScanner.scanBarcode(
              "#ff6666", "OK", true, ScanMode.BARCODE);
           /// HERE IS THE CHANGES WHICH I ADDED IT
           // BarcodeDetector detector=new BarcodeDetector.Builder(context)
           //     .setBarcodeFormats(Barcode.DATA_MATRIX | Barcode.QR_CODE)
           //     .build();
//0xFFF0F0F0
        } on PlatformException{
          barcodeScanRes='cant get the bar code';

        }
       // if (!mounted) return;
        barcodeScanRes=barcodeScanRes1;
        print('=========================================================================');
        print('=========================================================================');
        print('=========================================================================');
        print('=========================================================================');
        print('=========================================================================');

        print(barcodeScanRes);
        print(barcodeScanRes);
        print(barcodeScanRes);
        print(barcodeScanRes);
        print('helo');
        print('=========================================================================');
        print('=========================================================================');
        print('=========================================================================');
        print('=========================================================================');
        print('=========================================================================');
        print('=========================================================================');


        emit(BareCodeSecondState());
      }
      ///
      /// here for add product for data base event
      ///

      if(event is AddProductForDataBaseEvent){

        final product = <String, dynamic>{
          "name": "${event.name}",
          "price": "${event.price}",
          "barcode": "${event.barcode}"
        };

        print(product);



        emit(LoadingAddProductState());

      await  db.collection("products").add(product).then((DocumentReference doc) {
          emit(LoadedAddProductState());
        }
        ).catchError((error){
          emit(ErrorAddProductState(error: error));
        })

      ;



      }


    });
  }
}
