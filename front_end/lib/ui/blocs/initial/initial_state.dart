part of 'initial_bloc.dart';

enum InitialStatus { initial, loading, success, failure }

class InitialState extends Equatable {
  const InitialState(
      {required this.status, this.error, this.posDrawerSelected = 2});

  final InitialStatus status;
  final String? error;
  final int posDrawerSelected;

  @override
  List<Object?> get props => [status, error, posDrawerSelected];

  InitialState copyWith(
      {InitialStatus? status, String? error, int? posDrawerSelected}) {
    return InitialState(
        status: status ?? this.status,
        error: error,
        posDrawerSelected: posDrawerSelected ?? this.posDrawerSelected);
  }
}
