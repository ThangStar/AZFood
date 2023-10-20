import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_manager_app/apis/chart/chart.api.dart';
import 'package:restaurant_manager_app/utils/response.dart';

import '../../../model/income.dart';

part 'chart_event.dart';

part 'chart_state.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  ChartBloc() : super(const ChartState()) {
    // TODO: implement event handler
    on<GetIncomeAYear>(_getIncomeAYear);
  }

  FutureOr<void> _getIncomeAYear(
      GetIncomeAYear event, Emitter<ChartState> emit) async {
    Object result = await ChartApi.getIncomeAYear();
    if (result is Success) {
      print(result.response.data);
    } else if (result is Failure) {

    }
  }
}
