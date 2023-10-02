part of 'edit_price_bloc.dart';

abstract class EditPriceEvent extends Equatable {
  const EditPriceEvent();
  @override
  List<Object> get props => [];
}

class PutNewPriceEvent extends EditPriceEvent{
  final String name ;
  final String price ;
  final String barcode ;
  final String id ;
  const PutNewPriceEvent({
    required this.name,
    required this.price,
    required this.barcode,
    required this.id,
});
  @override
  List<Object> get props => [name,price,barcode,id];
}


