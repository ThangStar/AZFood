part of 'invoice_bloc.dart';

class InvoiceState extends Equatable {
  final List<Invoice> invoices;

  const InvoiceState({this.invoices = const []});

  @override
  List<Object?> get props => [invoices];

  InvoiceState copyWith({
    List<Invoice>? invoices,
  }) {
    return InvoiceState(
      invoices: invoices ?? this.invoices,
    );
  }
}

class InvoiceLoadingState extends InvoiceState {}
