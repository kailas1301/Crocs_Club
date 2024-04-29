import 'package:bloc/bloc.dart';
import 'package:crocs_club/data/services/orders/order_services.dart';
import 'package:crocs_club/domain/models/orders_model.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<FetchOrdersEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        final orders = await OrderApi.fetchOrders();
        emit(OrderLoaded(orders));
      } catch (e) {
        emit(OrderError('Failed to fetch orders: $e'));
      }
    });
    on<CancelOrdersEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        final response = await OrderApi.cancelOrder(event.id);
        if (response == 200) {
          emit(OrderCancelled());
          final orders = await OrderApi.fetchOrders();
          emit(OrderLoaded(orders));
        } else {
          emit(OrderCancelledError("order was not cancelled"));
        }
      } catch (e) {
        emit(OrderError('Failed to fetch orders: $e'));
      }
    });

    on<ReturnOrdersEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        final response = await OrderApi.returnOrder(event.id);
        if (response == 200) {
          emit(OrderReturned());
          final orders = await OrderApi.fetchOrders();
          emit(OrderLoaded(orders));
        } else {
          emit(OrderReturnedError("order was not returned"));
        }
      } catch (e) {
        emit(OrderError('Failed to fetch orders: $e'));
      }
    });
  }
}
