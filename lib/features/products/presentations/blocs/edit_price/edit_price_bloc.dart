import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_price_event.dart';
part 'edit_price_state.dart';

class EditPriceBloc extends Bloc<EditPriceEvent, EditPriceState> {

  static EditPriceBloc get(context)=>BlocProvider.of(context);
  var db = FirebaseFirestore.instance;


  EditPriceBloc() : super(EditPriceInitial()) {
    on<EditPriceEvent>((event, emit) async{

      if(event is PutNewPriceEvent){


        final product = <String, dynamic>{
          "name": "${event.name}",
          "price": "${event.price}",
          "barcode": "${event.barcode}"
        };
        emit(LoadingEditPriceState());
      await  db.collection('products').doc(event.id).update(product).then((value) {
          emit(LoadedEditPriceState());
        }).catchError((error){
          emit(ErrorEditPriceState(error: 'error.runtimeType as String'));
        });





      }




    });
  }
}
