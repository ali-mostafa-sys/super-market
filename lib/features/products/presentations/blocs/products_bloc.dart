import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  static ProductsBloc get(context)=> BlocProvider.of(context);
  String? barcodeScanRes;

 int price=0;

  var db = FirebaseFirestore.instance;

  List<AllProductModel>model=[];
  List<AllProductModel>newModel=[];
  List<AllProductModel>invoiceList=[];




  ProductsBloc() : super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) async{
      ///
      /// here for get all data
      ///

      if(event is GetAllProductEvent){
        emit(LoadingGetAllProductState());
        model=[];
        newModel=[];

        await db.collection("products").get().then((event) {

          for (var doc in event.docs) {
            AllProductModel data=AllProductModel.fromJson(doc.data());
            AllProductModel realData= AllProductModel(name: data.name,barcode: data.barcode,price: data.price,id:doc.id );
            model.add(realData);
            newModel.add(realData);

            print(" ${doc.data()}");

          }
          emit(LoadedGetAllProductState());
          print(model[0].name);
        }).catchError((error){
          emit(ErrorGetAllProductState(error: error));
        });



      }


      ///
      /// here for scan barcode event
      ///

      if(event is GetBareCodeEvent){
        String barcodeScanRes1='';

        emit(GetBareCodeFirstState());

        try{
          barcodeScanRes1 = await FlutterBarcodeScanner.scanBarcode(
              "#3a243b", "OK", true, ScanMode.BARCODE);

        } on PlatformException{
          barcodeScanRes='cant get the bar code';

        }
        // if (!mounted) return;
        barcodeScanRes=barcodeScanRes1;
        emit(GetBareCodeThirdState());


        print(barcodeScanRes);
        print(barcodeScanRes);
        print(barcodeScanRes);
        print(barcodeScanRes);
        print(model.length);

        for(int i=0; i<model.length;i++){

          if(barcodeScanRes==model[i].barcode){
            price=int.parse(model[i].price!)  +price;
            invoiceList.add(model[i]);

          }

        }


        // for(var data in model ){
        //
        //   if(data.barcode==barcodeScanRes)
        //     price=data.price;
        // }
        print('=================================================');
        print('=================================================');
        print('=================================================');
        print('=================================================');
        print('=================================================');
        print(price);
        print('=================================================');
        print('=================================================');
        print('=================================================');
        print('=================================================');
        print('=================================================');
        print('=================================================');



        emit(GetBareCodeSecondState());
      }
      ///
      /// here dor delete
      ///

      if(event is DeleteProductEvent){
        emit(LoadingDeleteProductState());

       await db.collection('products').doc(event.id).delete().then((value) {
          emit(LoadedDeleteProductState());

        }).catchError((onError){
          emit(ErrorDeleteProductState(error: 'يرجى المحاولة مرة لاحقة'));
        });
      }
      ///
      /// here for new invoice event
      ///
      if(event is NewInvoiceEvent){
        emit(NewInvoiceFirstState());
        price=0;
        invoiceList=[];
        emit(NewInvoiceSecondState());
      }
      ///
      /// here for search for product event
      ///

      if(event is SearchForProductEvent){
       List newModelSearch=newModel;
        emit(SearchForProductFirstState());

        final modelOne=newModel.where((productList) {
          final productName=productList.name!.toLowerCase();
          final input=event.searchText.toLowerCase();
          return productName.contains(input);

        }).toList();
        model=modelOne;






       emit(SearchForProductSecondState());


      }
      ///
      /// here for delete product from invoice list event
      ///

      if(event is DeleteProductFromInvoiceListEvent){
        emit(DeleteProductFromInvoiceListFirstState());


        List<AllProductModel> newInvoiceModel=invoiceList;


        final modelOne=newModel.where((productList) {
          final productName=productList.barcode!.toLowerCase();
          final input=event.barcode.toLowerCase();
          return productName.contains(input);

        });

        for(int i=0;i<newInvoiceModel.length;i++){
          if(modelOne.first.barcode==newInvoiceModel[i].barcode){
            newInvoiceModel.remove(newInvoiceModel[i]);
            break;
          }

        }



        //newInvoiceModel.remove(modelOne);
        invoiceList= newInvoiceModel;
       price=price-int.parse(modelOne.first.price!);



       emit(DeleteProductFromInvoiceListSecondState());








      }












    });
  }
}


class AllProductModel{
final String? id;
final String? name;
final String? price;
final String? barcode;

const AllProductModel({
  required this.name,
   this.id,
  required this.price,
  required this.barcode,
});

factory  AllProductModel.fromJson(Map<String,dynamic>json){
  final name=json['name'];
  final price=json['price'];
  final barcode=json['barcode'];
  return AllProductModel(name: name, price: price, barcode: barcode);



}



Map<String,dynamic>toJson(){
  return{
    'name':name.toString(),
    'price':price.toString(),
    'barcode':barcode.toString(),


  };
}







}