part of 'table_bloc.dart';

abstract class TableEvent extends Equatable {
  const TableEvent();

  @override
  List<Object> get props => [];
}

class OnTableChange extends TableEvent {
  final List<Table> tables;

  const OnTableChange({required this.tables});
}

class OnFilterTable extends TableEvent {
  final int status;

  const OnFilterTable({this.status = 0});
}

class UpdateStatusEvent extends TableEvent {
  final int idTable;
  final int status;

  UpdateStatusEvent({required this.idTable, required this.status});
}
