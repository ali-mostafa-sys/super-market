part of 'edit_price_bloc.dart';

abstract class EditPriceState extends Equatable {
  const EditPriceState();
  @override
  List<Object> get props => [];
}

class EditPriceInitial extends EditPriceState {
  @override
  List<Object> get props => [];
}

class LoadingEditPriceState extends EditPriceState{}
class LoadedEditPriceState extends EditPriceState{}
class ErrorEditPriceState extends EditPriceState{

  final String error;
  const ErrorEditPriceState({
    required this.error
});
  @override
  List<Object> get props => [error];

}














