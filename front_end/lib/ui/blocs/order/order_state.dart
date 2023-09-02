part of 'order_bloc.dart';

enum OrderStatus { initial, loading, success, failure }

class OrderState extends Equatable {
  const OrderState({
    required this.status,
    this.error,
  });

  final OrderStatus status;
  final String? error;

  @override
  List<Object?> get props => [status, error];

  OrderState copyWith({
    OrderStatus? status,
    String? error,
  }) {
    return OrderState(
      status: status ?? this.status,
      error: error,
    );
  }
}
