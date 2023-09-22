part of 'table_bloc.dart';

enum TableStatus { initial, loading, success, failure }

class TableState extends Equatable {
  const TableState(
      {required this.status,
      this.error,
      this.tables = const [],
      this.tablesFilter = const []});

  final List<Table> tables;
  final List<Table> tablesFilter;
  final TableStatus status;
  final String? error;

  @override
  List<Object?> get props => [status, error, tables, tablesFilter];

  TableState copyWith({
    List<Table>? tables,
    List<Table>? tablesFilter,
    TableStatus? status,
    String? error,
  }) {
    return TableState(
      tables: tables ?? this.tables,
      tablesFilter: tablesFilter ?? this.tablesFilter,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
