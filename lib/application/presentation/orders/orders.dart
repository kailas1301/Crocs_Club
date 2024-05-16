import 'package:crocs_club/application/business_logic/address/bloc/adressbloc_bloc.dart';
import 'package:crocs_club/application/business_logic/order/bloc/order_bloc.dart';
import 'package:crocs_club/application/presentation/orders/widgets/orderTile.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/models/address_model.dart';
import 'package:crocs_club/domain/utils/functions/functions.dart';
import 'package:crocs_club/domain/utils/widgets/loading_animations.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OrderBloc>(context).add(FetchOrdersEvent());
    BlocProvider.of<AdressblocBloc>(context).add(GetAddressEvent());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const AppBarTextWidget(title: 'Orders'),
        ),
        body: BlocBuilder<AdressblocBloc, AdressblocState>(
          builder: (context, adressstate) {
            if (adressstate is AdressblocLoading) {
              return const LoadingAnimationStaggeredDotsWave();
            }
            if (adressstate is AdressblocLoaded) {
              return BlocConsumer<OrderBloc, OrderState>(
                listener: (context, state) {
                  if (state is OrderReturned) {
                    showCustomSnackbar(context, "order was returned",
                        kGreenColour, kwhiteColour);
                  }
                  if (state is OrderCancelled) {
                    showCustomSnackbar(context, "order was cancelled",
                        kGreenColour, kwhiteColour);
                  }
                  if (state is OrderReturnedError) {
                    showCustomSnackbar(context, "order was not returned",
                        kRedColour, kwhiteColour);
                  }
                  if (state is OrderCancelledError) {
                    showCustomSnackbar(context, "order was not cancelled",
                        kRedColour, kwhiteColour);
                  }
                },
                builder: (context, orderstate) {
                  if (orderstate is OrderLoading) {
                    return const LoadingAnimationStaggeredDotsWave();
                  } else if (orderstate is OrderLoaded) {
                    return ListView.builder(
                      itemCount: orderstate.orders.length,
                      itemBuilder: (context, index) {
                        AddressModel address = adressstate.addressModel
                            .firstWhere((adress) =>
                                adress.id ==
                                orderstate.orders[index].addressId);
                        final order = orderstate.orders[index];
                        return OrderTile(address: address, order: order);
                      },
                    );
                  } else if (orderstate is OrderError) {
                    return const Center(
                        child: SubHeadingTextWidget(
                      title: 'No orders found',
                      textColor: kDarkGreyColour,
                    ));
                  } else {
                    return const LoadingAnimationStaggeredDotsWave();
                  }
                },
              );
            } else if (State is AdressblocError) {
              print("the state is $adressstate");
              return const Center(
                  child: SubHeadingTextWidget(
                title: 'No orders found',
                textColor: kDarkGreyColour,
              ));
            } else {
              print(adressstate);
              return const LoadingAnimationStaggeredDotsWave();
            }
          },
        ),
      ),
    );
  }
}
