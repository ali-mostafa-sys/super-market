part of 'add_product_bloc.dart';

abstract class AddProductState extends Equatable {
  const AddProductState();
  @override
  List<Object> get props => [];
}

class AddProductInitial extends AddProductState {
  @override
  List<Object> get props => [];
}
///
///her for scan barcode
///

class BareCodeFirstState extends AddProductState{}
class BareCodeSecondState extends AddProductState{}

///
///here for add product
///

class LoadingAddProductState extends AddProductState{}
class LoadedAddProductState extends AddProductState{}
class ErrorAddProductState extends AddProductState{
  final String error;
  const ErrorAddProductState({required this.error});
  @override
  List<Object> get props => [];

}







