part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {
  @override
  List<Object> get props => [];
}
///
/// here for get all product state
///

class LoadingGetAllProductState extends ProductsState{}
class LoadedGetAllProductState extends ProductsState{}

class ErrorGetAllProductState extends ProductsState{
  final String error;
  const  ErrorGetAllProductState ({
    required this.error
});
  @override
  List<Object> get props => [error];

}


///
///her for scan barcode
///

class GetBareCodeFirstState extends ProductsState{}
class GetBareCodeSecondState extends ProductsState{}
class GetBareCodeThirdState extends ProductsState{}

///
/// here for delete product
///
class LoadingDeleteProductState extends ProductsState{}
class LoadedDeleteProductState extends ProductsState{}
class ErrorDeleteProductState extends ProductsState{
  final String error;
  const ErrorDeleteProductState({
    required this.error
});
  @override
  List<Object> get props => [error];
}

///
/// new invoice state
///
class NewInvoiceFirstState extends ProductsState{}
class NewInvoiceSecondState extends ProductsState{}

///
/// search for product state
///

class SearchForProductFirstState extends ProductsState{}
class SearchForProductSecondState extends ProductsState{}

///
/// delete product from invoice list state
///

class DeleteProductFromInvoiceListFirstState extends ProductsState{}
class DeleteProductFromInvoiceListSecondState extends ProductsState{}








