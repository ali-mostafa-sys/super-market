import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  static MainBloc get(context)=>BlocProvider.of(context);

  bool showPasswordDialog=false;
  String password='11';




  MainBloc() : super(MainInitial()) {
    on<MainEvent>((event, emit) async{
      ///
      /// here for dialog
      ///
      if(event is ShowPasswordDialogEvent){
        emit(FirstShowPasswordDialogState());
        showPasswordDialog=!showPasswordDialog;
        emit(SecondShowPasswordDialogState());
      }

      ///
      /// here for password
      ///
      if(event is PasswordAndNavigateEvent){

        if(event.password==password){
          emit(CorrectPasswordState());
        }else{
          emit(FalsePasswordState());
        }

      }



    });
  }
}
