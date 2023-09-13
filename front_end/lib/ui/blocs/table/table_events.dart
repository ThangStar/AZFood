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
