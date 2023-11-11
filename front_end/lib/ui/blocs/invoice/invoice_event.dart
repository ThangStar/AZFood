part of 'invoice_bloc.dart';

class InvoiceEvent extends Equatable {
  const InvoiceEvent();

  @override
  List<Object?> get props => [];
}

class GetInvoiceEvent extends InvoiceEvent {}

class GetInvoiceByIdEvent extends InvoiceEvent {
  final int id;
  const GetInvoiceByIdEvent({required this.id});
}

class GetInvoiceByIdUserEvent extends InvoiceEvent {
  final int userID;
  final String keysearch;
  const GetInvoiceByIdUserEvent({required this.userID, required this.keysearch});
}

