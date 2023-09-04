part of 'table_bloc.dart';

enum TableStatus { initial, loading, success, failure }

class TableState extends Equatable {
  const TableState({required this.status, this.error, this.tables = const []});
  final List<Table> tables;
  final TableStatus status;
  final String? error;

  @override
  List<Object?> get props => [status, error, tables];

  TableState copyWith(
      {TableStatus? status, String? error, List<Table>? tables}) {
    return TableState(
        status: status ?? this.status,
        error: error,
        tables: tables ?? this.tables);
  }
}
