part of 'chart_bloc.dart';

class ChartState extends Equatable {
  const ChartState({this.incomesYear = const []});
  final List<Income> incomesYear;
  @override
  // TODO: implement props
  List<Object?> get props => [];

  ChartState copyWith({
    List<Income>? incomesYear,
  }) {
    return ChartState(
      incomesYear: incomesYear ?? this.incomesYear,
    );
  }
}


