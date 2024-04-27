import 'package:bloc/bloc.dart';
import 'package:crocs_club/data/services/orders/order_services.dart';
import 'package:crocs_club/domain/models/orders_model.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        final orders = await OrderApi.fetchOrders();
        emit(OrderLoaded(orders));
      } catch (e) {
        emit(OrderError('Failed to fetch orders: $e'));
      }
    });
  }
}
