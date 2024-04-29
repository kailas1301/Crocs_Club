import 'package:crocs_club/application/business_logic/address/bloc/adressbloc_bloc.dart';
import 'package:crocs_club/application/business_logic/order/bloc/order_bloc.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/models/address_model.dart';
import 'package:crocs_club/domain/utils/functions/functions.dart';
import 'package:crocs_club/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:crocs_club/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  return const Center(child: CircularProgressIndicator());
                } else if (orderstate is OrderLoaded) {
                  return ListView.builder(
                    itemCount: orderstate.orders.length,
                    itemBuilder: (context, index) {
                      AddressModel address = adressstate.addressModel
                          .firstWhere((adress) =>
                              adress.id == orderstate.orders[index].addressId);
                      final order = orderstate.orders[index];
                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: const Color.fromARGB(255, 226, 222, 222),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: SubHeadingTextWidget(
                                      textsize: 15,
                                      textColor: kDarkGreyColour,
                                      title: 'Ordered By: ${address.name}',
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const SubHeadingTextWidget(
                                                title: 'Final Price: ',
                                                textsize: 13,
                                                textColor: kDarkGreyColour),
                                            SubHeadingTextWidget(
                                              title:
                                                  '₹${order.finalPrice.toStringAsFixed(2)}',
                                              textColor: kGreenColour,
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const SubHeadingTextWidget(
                                                title: 'Order Status : ',
                                                textsize: 13,
                                                textColor: kDarkGreyColour),
                                            SubHeadingTextWidget(
                                              title: order.orderStatus,
                                              textColor:
                                                  order.orderStatus == 'PENDING'
                                                      ? kRedColour
                                                      : order.orderStatus ==
                                                              'DELIVERED'
                                                          ? kGreenColour
                                                          : kRedColour,
                                            ),
                                          ],
                                        ),
                                        SubHeadingTextWidget(
                                            textColor: kDarkGreyColour,
                                            textsize: 13,
                                            title: 'Phone: ${address.phone}'),
                                        Text(
                                          'Shipping Address: ${address.name}, ${address.houseName}, ${address.city}',
                                          style: GoogleFonts.roboto(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Add onTap or trailing icon for more actions
                                  ),
                                ),
                                kSizedBoxW10, // Add some space between details and buttons
                                if (order.orderStatus == 'PENDING')
                                  SizedBox(
                                    width: screenWidth * .3,
                                    child: ElevatedButtonWidget(
                                      textsize: 14,
                                      onPressed: () {
                                        BlocProvider.of<OrderBloc>(context).add(
                                            CancelOrdersEvent(id: order.id));
                                      },
                                      buttonText: 'Cancel',
                                    ),
                                  ),
                                if (order.orderStatus == 'DELIVERED')
                                  SizedBox(
                                    width: screenWidth * .3,
                                    child: ElevatedButtonWidget(
                                      textsize: 14,
                                      onPressed: () {
                                        BlocProvider.of<OrderBloc>(context).add(
                                            ReturnOrdersEvent(id: order.id));
                                      },
                                      buttonText: 'Return',
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
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
