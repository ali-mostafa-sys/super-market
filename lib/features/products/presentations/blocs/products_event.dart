part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
  @override
  List<Object> get props => [];
}


class GetAllProductEvent extends ProductsEvent{}

/// get par code
class GetBareCodeEvent extends ProductsEvent{}
///
/// delete product
///
class DeleteProductEvent extends ProductsEvent{
  final String id;
  const DeleteProductEvent({
    required this.id
});
  @override
  List<Object> get props => [id];
}
///
/// new invoice event
///

class NewInvoiceEvent extends ProductsEvent{}
///
/// search for product event
///
class SearchForProductEvent extends ProductsEvent{
  final String searchText;
  const SearchForProductEvent({
    required this.searchText
});
  @override
  List<Object> get props => [searchText];

}

///
/// delete product from invoice list
///

class DeleteProductFromInvoiceListEvent extends ProductsEvent{
  final String barcode;
  const DeleteProductFromInvoiceListEvent({
    required this.barcode,
});
  @override
  List<Object> get props => [barcode];


}












