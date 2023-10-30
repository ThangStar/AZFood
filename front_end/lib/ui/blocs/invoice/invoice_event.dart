part of 'invoice_bloc.dart';

class InvoiceEvent extends Equatable {
  const InvoiceEvent();

  @override
  List<Object?> get props => [];
}

class GetInvoiceEvent extends InvoiceEvent {}

class GetInvoiceByIdUserEvent extends InvoiceEvent {
  final int id;
  const GetInvoiceByIdUserEvent({required this.id});
}
