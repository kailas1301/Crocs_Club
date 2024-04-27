import 'package:crocs_club/application/business_logic/address/bloc/adressbloc_bloc.dart';
import 'package:crocs_club/application/business_logic/order/bloc/order_bloc.dart';
import 'package:crocs_club/domain/models/address_model.dart';
import 'package:crocs_club/domain/models/orders_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OrderBloc>(context).add(FetchOrdersEvent());
    BlocProvider.of<AdressblocBloc>(context).add(GetAddressEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: BlocBuilder<AdressblocBloc, AdressblocState>(
        builder: (context, adressstate) {
          if (adressstate is AdressblocLoading) {
            return const CircularProgressIndicator();
          }
          if (adressstate is AdressblocLoaded) {
            return BlocBuilder<OrderBloc, OrderState>(
              builder: (context, orderstate) {
                if (orderstate is OrderLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (orderstate is OrderLoaded) {
                  return ListView.builder(
                    itemCount: orderstate.orders.length,
                    itemBuilder: (context, index) {
                      AddressModel adress = adressstate.addressModel.firstWhere(
                          (adress) =>
                              adress.id == orderstate.orders[index].addressId);
                      final order = orderstate.orders[index];
                      return ListTile(
                        title: Text('Order ID: ${order.id}'),
                        subtitle: Column(
                          children: [
                            Text(
                                'Final Price: \$${order.finalPrice.toStringAsFixed(2)}'),
                            Text('Final Price: \$${order.orderStatus}'),
                            Text('Final Price: \$${adress.name}'),
                            Text('Final Price: \$${order.paymentMethodId}'),
                          ],
                        ),
                        // Add more details as needed
                      );
                    },
                  );
                } else if (orderstate is OrderError) {
                  return Center(child: Text('Error: ${orderstate.message}'));
                } else {
                  return const Center(child: Text('Unknown state'));
                }
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
