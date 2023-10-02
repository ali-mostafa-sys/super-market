part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
  @override
  List<Object> get props => [];
}
///
///  show password dialog event
///
class ShowPasswordDialogEvent extends MainEvent{}
///
///  password and navigate
///
class PasswordAndNavigateEvent extends MainEvent{
  final String password;
  const PasswordAndNavigateEvent({
    required this.password
});

  @override
  List<Object> get props => [password];

}










