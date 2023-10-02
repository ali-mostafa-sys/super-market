part of 'add_product_bloc.dart';

abstract class AddProductEvent extends Equatable {
  const AddProductEvent();
  @override
  List<Object> get props => [];
}


class BareCodeEvent extends AddProductEvent{}

class AddProductForDataBaseEvent extends AddProductEvent{
  final String name ;
  final String price;
  final String barcode;
  const AddProductForDataBaseEvent({
    required this.name,
    required this.price,
    required this.barcode,
});
  @override
  List<Object> get props => [name,price,barcode];


}
