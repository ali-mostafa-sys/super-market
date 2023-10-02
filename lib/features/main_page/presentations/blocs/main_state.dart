part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  const MainState();
  @override
  List<Object> get props => [];
}

class MainInitial extends MainState {
  @override
  List<Object> get props => [];
}

///
/// show password dialog state
///
class FirstShowPasswordDialogState extends MainState{}
class SecondShowPasswordDialogState extends MainState{}
///
/// password navigator state
///
class CorrectPasswordState extends MainState{}
class FalsePasswordState extends MainState{}




