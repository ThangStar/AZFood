part of 'invoice_bloc.dart';

class InvoiceState extends Equatable {
  final Invoice? invoice;
  final List<Invoice> invoices;

  const InvoiceState({this.invoices = const [], this.invoice});

  @override
  List<Object?> get props => [invoices, invoice];

  InvoiceState copyWith({
    Invoice? invoice,
    List<Invoice>? invoices,

  }) {
    return InvoiceState(
      invoice: invoice ?? this.invoice,
      invoices: invoices ?? this.invoices,

    );
  }
}

class InvoiceLoadingState extends InvoiceState {}
class InvoiceLoadingByIdUserState extends InvoiceState {}
class InvoiceLoadingByIdState extends InvoiceState {
  @override
  final List<Invoice> invoices;
 
  InvoiceLoadingByIdState({required this.invoices});
}
