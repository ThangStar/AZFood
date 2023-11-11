import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:restaurant_manager_app/apis/invoice/invoice.api.dart';
import 'package:restaurant_manager_app/utils/response.dart';

import '../../../model/invoice.dart';

part 'invoice_event.dart';

part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  InvoiceBloc() : super(const InvoiceState()) {
    on<GetInvoiceEvent>(_getInvoiceEvent);
    on<GetInvoiceByIdUserEvent>(_getInvoiceByIdUserEvent);
    on<GetInvoiceByIdEvent>(_getInvoiceByIdEvent);
  }

  FutureOr<void> _getInvoiceEvent(
      GetInvoiceEvent event, Emitter<InvoiceState> emit) async {
    emit(InvoiceLoadingState());
    await Future.delayed(200.milliseconds);
    Object result = await InvoiceApi.getAll();
    if (result is Success) {
      final data = result.response.data['resultRaw'] as List<dynamic>;
      List<Invoice> invoices = data.map((e) => Invoice.fromJson(e)).toList();
      emit(state.copyWith(invoices: invoices));
    } else if (result is Failure) {}
  }

  FutureOr<void> _getInvoiceByIdUserEvent(
      GetInvoiceByIdUserEvent event, Emitter<InvoiceState> emit) async {
    emit(InvoiceLoadingByIdUserState());
    await Future.delayed(200.milliseconds);
    Object result = await InvoiceApi.getByIdUser(event.userID, event.keysearch);
    if (result is Success) {
      final data = result.response.data['resultRaw'] as List<dynamic>;
      List<Invoice> invoices = data.map((e) => Invoice.fromJson(e)).toList();
      emit(state.copyWith(invoices: invoices));
    } else if (result is Failure) {}
  }

  FutureOr<void> _getInvoiceByIdEvent(
      GetInvoiceByIdEvent event, Emitter<InvoiceState> emit) async {
    emit(InvoiceLoadingByIdState(invoices: state.invoices));
      Object result = await InvoiceApi.getById(event.id);
      if (result is Success) {
        Invoice invoice = Invoice.fromJson(jsonDecode(result.response.toString()));
        print("${result.response}");
        emit(state.copyWith(invoice: invoice));
      } else if (result is Failure) {}
  }
}
