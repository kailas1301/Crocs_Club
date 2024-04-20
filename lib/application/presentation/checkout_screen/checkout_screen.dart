import 'package:crocs_club/data/services/get_checkout/get_checkout.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/functions/functions.dart';
import 'package:crocs_club/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crocs_club/application/business_logic/checkout/bloc/checkout_bloc.dart';
import 'package:crocs_club/domain/models/checkout_details.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppBarTextWidget(title: 'Checkout'),
      ),
      body: BlocProvider(
        create: (context) =>
            CheckoutBloc(CheckOutServices())..add(LoadCheckoutDetails()),
        child: BlocConsumer<CheckoutBloc, CheckoutState>(
          listener: (context, state) {
            if (state is CheckoutSuccess) {
              showCustomSnackbar(context, 'Order succesfully placed',
                  kGreenColour, kwhiteColour);
            }
            if (state is CheckoutOrderError) {
              showCustomSnackbar(
                  context, 'Order was not placed', kRedColour, kwhiteColour);
            }
          },
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CheckoutLoaded) {
              final checkoutData = state.checkoutData;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SubHeadingTextWidget(
                      title: 'Selected Address:',
                    ),
                    kSizedBoxH10,
                    if (checkoutData.addresses.isEmpty)
                      const Text(
                          'No addresses found. Please add an address first.')
                    else
                      Column(
                        children: checkoutData.addresses
                            .map((address) =>
                                _buildAddressTile(context, address))
                            .toList(),
                      ),
                    kSizedBoxH10,
                    const SubHeadingTextWidget(
                      title: 'Order Details:',
                      textColor: kDarkGreyColour,
                    ),
                    kSizedBoxH10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubHeadingTextWidget(
                            textColor: kRedColour,
                            title:
                                'No. of Products: ${checkoutData.products.length}'),
                        SubHeadingTextWidget(
                            textColor: kGreenColour,
                            title:
                                'Subtotal: ${checkoutData.products.fold(0, (sum, product) => sum + product.totalPrice)}'),
                      ],
                    ),
                    kSizedBoxH20,
                    const SubHeadingTextWidget(
                      title: 'Select Payment Method:',
                      textsize: 20,
                    ),
                    kSizedBoxH10,
                    Column(
                      children: checkoutData.paymentMethods
                          .map((method) =>
                              _buildPaymentMethodTile(context, method))
                          .toList(),
                    ),
                    kSizedBoxH10,
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButtonWidget(
                        buttonText: 'Place Order',
                        onPressed: () {
                          if ((state.selectedAddressId == null ||
                              state.selectedPaymentMethodId == null)) {
                            showCustomSnackbar(
                                context,
                                'Please select an address and payment method',
                                kRedColour,
                                kwhiteColour);
                            return;
                          }
                          BlocProvider.of<CheckoutBloc>(context)
                              .add(PlaceOrder());
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is CheckoutOrderError) {
              return const Center(
                  child: SubHeadingTextWidget(
                title: 'Order was not placed',
              ));
            } else if (state is CheckoutSuccess) {
              return const Center(
                  child: SubHeadingTextWidget(
                      title: 'Order Placed Successfully!'));
            } else {
              return const SubHeadingTextWidget(title: 'Unexpected state');
            }
          },
        ),
      ),
    );
  }

  Widget _buildAddressTile(BuildContext context, Address address) {
    return BlocProvider.value(
      value: BlocProvider.of<CheckoutBloc>(context),
      child: ListTile(
        title: SubHeadingTextWidget(
            textColor: kDarkGreyColour,
            textsize: 14,
            title:
                '${address.name}\n${address.houseName}, ${address.street}\n${address.city}, ${address.state} - ${address.pin}'),
        trailing: Radio<int>(
          activeColor: kAppPrimaryColor,
          value: address.id,
          groupValue: BlocProvider.of<CheckoutBloc>(context).state
                  is CheckoutLoaded
              ? (BlocProvider.of<CheckoutBloc>(context).state as CheckoutLoaded)
                  .selectedAddressId
              : null,
          onChanged: (value) {
            BlocProvider.of<CheckoutBloc>(context)
                .add(SelectAddress(addressId: value!));
          },
        ),
      ),
    );
  }

  Widget _buildPaymentMethodTile(BuildContext context, PaymentMethod method) {
    return BlocProvider.value(
      value: BlocProvider.of<CheckoutBloc>(context),
      child: ListTile(
        title: SubHeadingTextWidget(
            textColor: kDarkGreyColour, title: method.paymentName),
        trailing: Radio<int>(
          activeColor: kAppPrimaryColor,
          value: method.id, // Use the ID of the payment method as the value
          groupValue: BlocProvider.of<CheckoutBloc>(context).state
                  is CheckoutLoaded
              ? (BlocProvider.of<CheckoutBloc>(context).state as CheckoutLoaded)
                  .selectedPaymentMethodId
              : null,
          onChanged: (value) {
            BlocProvider.of<CheckoutBloc>(context)
                .add(SelectPaymentMethod(paymentMethodId: value!));
          },
        ),
      ),
    );
  }
}
