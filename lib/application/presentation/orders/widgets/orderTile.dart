import 'package:crocs_club/application/business_logic/order/bloc/order_bloc.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/models/address_model.dart';
import 'package:crocs_club/domain/models/orders_model.dart';
import 'package:crocs_club/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:crocs_club/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({
    super.key,
    required this.address,
    required this.order,
  });

  final AddressModel address;
  final Order order;

  @override
  Widget build(BuildContext context) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const SubHeadingTextWidget(
                              title: 'Final Price: ',
                              textsize: 13,
                              textColor: kDarkGreyColour),
                          SubHeadingTextWidget(
                            title: '₹${order.finalPrice.floor()}',
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
                            textColor: order.orderStatus == 'PENDING'
                                ? kRedColour
                                : order.orderStatus == 'DELIVERED'
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
              if (order.orderStatus == 'PENDING' ||
                  order.orderStatus == 'SHIPPED')
                SizedBox(
                  width: screenWidth * .3,
                  child: ElevatedButtonWidget(
                    textsize: 14,
                    onPressed: () {
                      BlocProvider.of<OrderBloc>(context)
                          .add(CancelOrdersEvent(id: order.id));
                    },
                    buttonText: 'Cancel',
                  ),
                ),
              // if (order.orderStatus == 'DELIVERED')
              //   SizedBox(
              //     width: screenWidth * .3,
              //     child: ElevatedButtonWidget(
              //       textsize: 14,
              //       onPressed: () {
              //         BlocProvider.of<OrderBloc>(context)
              //             .add(ReturnOrdersEvent(id: order.id));
              //       },
              //       buttonText: 'Return',
              //     ),
              //   ),
            ],
          ),
        ],
      ),
    );
  }
}
