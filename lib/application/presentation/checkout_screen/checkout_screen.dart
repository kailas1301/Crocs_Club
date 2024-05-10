import 'package:cached_network_image/cached_network_image.dart';
import 'package:crocs_club/application/business_logic/cart/bloc/cart_bloc.dart';
import 'package:crocs_club/application/business_logic/coupon/bloc/coupon_bloc.dart';
import 'package:crocs_club/application/business_logic/wallet/bloc/wallet_bloc.dart';
import 'package:crocs_club/application/presentation/adress_screen/adress_screen.dart';
import 'package:crocs_club/application/presentation/adress_screen/widgets.dart/add_adress.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/models/checkout_product.dart';
import 'package:crocs_club/domain/models/coupon_model.dart';
import 'package:crocs_club/domain/utils/functions/functions.dart';
import 'package:crocs_club/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocs_club/domain/utils/widgets/loading_animations.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:crocs_club/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crocs_club/application/business_logic/checkout/bloc/checkout_bloc.dart';
import 'package:crocs_club/domain/models/checkout_details.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CheckOutProductModel> checkoutProducts;
  const CheckoutScreen({super.key, required this.checkoutProducts});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late Razorpay _razorpay;
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Successful",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white);
    BlocProvider.of<CheckoutBloc>(context).add(PlaceOrder());
    print("success");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CouponBloc>(context).add(LoadCouponsEvent());
    BlocProvider.of<CheckoutBloc>(context).add(LoadCheckoutDetails());
    BlocProvider.of<WalletBloc>(context).add(FetchWallet());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppBarTextWidget(title: 'Checkout'),
      ),
      body: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, walletstate) {
          if (walletstate is WalletLoading) {
            return const LoadingAnimationStaggeredDotsWave();
          } else if (walletstate is WalletLoaded) {
            return BlocConsumer<CheckoutBloc, CheckoutState>(
              listener: (context, checkoutstate) {
                if (checkoutstate is CheckoutSuccess) {
                  showCustomSnackbar(context, 'Order succesfully placed',
                      kGreenColour, kwhiteColour);
                  BlocProvider.of<CartBloc>(context).add(FetchCartEvent());
                  Navigator.of(context).pop();
                }
                if (checkoutstate is CheckoutOrderError) {
                  showCustomSnackbar(context, 'Order was not placed',
                      kRedColour, kwhiteColour);
                }
                if (checkoutstate is PaymentSuccess) {
                  showCustomSnackbar(context, 'Payment was successfull',
                      kGreenColour, kwhiteColour);
                }
                if (checkoutstate is CheckoutOrderError) {
                  showCustomSnackbar(context, 'Payment was not successfull',
                      kRedColour, kwhiteColour);
                }
              },
              builder: (context, state) {
                if (state is CheckoutLoading) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: kAppPrimaryColor,
                      size: 40,
                    ),
                  );
                } else if (state is CheckoutLoaded) {
                  final checkoutData = state.checkoutData;
                  double discountedAmount = 0.0;
                  if (state.selectedCouponId != null) {
                    final selectedCoupon = state.coupons!.firstWhere(
                        (coupon) => coupon.id == state.selectedCouponId);
                    if (selectedCoupon.id != -1) {
                      discountedAmount = checkoutData.products.fold(
                              0, (sum, product) => sum + product.totalPrice) *
                          (selectedCoupon.discountPercentage / 100);
                    }
                  }

                  double payableAmount = checkoutData.products
                          .fold(0, (sum, product) => sum + product.totalPrice) -
                      discountedAmount;

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kSizedBoxH10,
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SubHeadingTextWidget(
                              title: 'Order Details:',
                              textColor: kDarkGreyColour,
                            ),
                          ),
                          kSizedBoxH10,

                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: checkoutData.products.length,
                            itemBuilder: (context, index) {
                              final product = widget.checkoutProducts[index];
                              return ListTile(
                                leading: CachedNetworkImage(
                                  imageUrl: product
                                      .imageUrl, // Assuming imageUrl is a property of CheckoutProductModel
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: screenWidth * .2,
                                    height: screenWidth * .3,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => Container(
                                      alignment: Alignment.center,
                                      child: const CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                title: PriceTextWidget(
                                    textsize: 13, title: product.name),
                                subtitle: PriceTextWidget(
                                    textsize: 13,
                                    title: 'Quantity: ${product.quantity}'),
                                trailing: PriceTextWidget(
                                  title: '₹${product.finalPrice}',
                                  textColor: kGreenColour,
                                  textsize: 13,
                                ),
                              );
                            },
                          ),
                          kSizedBoxH10,
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    SubHeadingTextWidget(
                                        textColor: kblackColour,
                                        title:
                                            'No. of Products: ${checkoutData.products.length}'),
                                    PriceTextWidget(
                                        textColor: kGreenColour,
                                        title:
                                            'Subtotal: ₹${checkoutData.products.fold(0, (sum, product) => sum + product.totalPrice)}'),
                                  ],
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            const AddAddressScreen(),
                                      ));
                                    },
                                    child: const PriceTextWidget(
                                        textColor: kDarkGreyColour,
                                        textsize: 12,
                                        title: "Add new Address")),
                              ],
                            ),
                          ),
                          kSizedBoxH10,

                          if (checkoutData.addresses.isEmpty)
                            const SubHeadingTextWidget(
                                title:
                                    'No addresses found. Please add an address first.')
                          else
                            ExpansionTile(
                              title: const SubHeadingTextWidget(
                                title: 'Selected Address:',
                              ),
                              children: checkoutData.addresses
                                  .map((address) =>
                                      _buildAddressTile(context, address))
                                  .toList(),
                            ),

                          ExpansionTile(
                            title: const SubHeadingTextWidget(
                              title: 'Selected Payment Method:',
                            ),
                            children: checkoutData.paymentMethods
                                .map((method) =>
                                    _buildPaymentMethodTile(context, method))
                                .toList(),
                          ),

                          kSizedBoxH10,
                          ExpansionTile(
                            title: const SubHeadingTextWidget(
                              title: 'Selected Coupon',
                            ),
                            children: state.coupons!
                                .map((coupon) => _buildCouponTile(
                                    context,
                                    coupon,
                                    checkoutData.products.fold(
                                        0,
                                        (sum, product) =>
                                            sum + product.totalPrice)))
                                .toList(),
                          ),
                          // BlocBuilder<WalletBloc, WalletState>(
                          //   builder: (context, walletstate) {
                          //     if (walletstate is WalletLoaded) {
                          //       return BlocBuilder<CheckoutBloc, CheckoutState>(
                          //         builder: (context, checkoutstate) {
                          //           if (checkoutstate is CheckoutLoaded) {
                          //             return Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.start,
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.start,
                          //               children: [
                          //                 ListTile(
                          //                   title: const SubHeadingTextWidget(
                          //                       title: 'Use Wallet Amount'),
                          //                   trailing: Switch(
                          //                       activeColor: kAppPrimaryColor,
                          //                       value:
                          //                           checkoutstate.useWallet ??
                          //                               false,
                          //                       onChanged: (value) {
                          //                         final walletAmount =
                          //                             walletstate.walletAmount;
                          //                         final payableAmount =
                          //                             checkoutData.products
                          //                                     .fold(
                          //                                   0,
                          //                                   (sum, product) =>
                          //                                       sum +
                          //                                       product
                          //                                           .totalPrice,
                          //                                 ) -
                          //                                 discountedAmount;

                          //                         if (walletAmount >=
                          //                             payableAmount) {
                          //                           BlocProvider.of<
                          //                                       CheckoutBloc>(
                          //                                   context)
                          //                               .add(SelectWallet(
                          //                                   useWallet: true));
                          //                         } else {
                          //                           showCustomSnackbar(
                          //                             context,
                          //                             'Wallet amount is insufficient for this transaction',
                          //                             kRedColour,
                          //                             kwhiteColour,
                          //                           );
                          //                           BlocProvider.of<
                          //                                       CheckoutBloc>(
                          //                                   context)
                          //                               .add(SelectWallet(
                          //                                   useWallet: false));
                          //                         }
                          //                       }),
                          //                 ),
                          //                 Padding(
                          //                   padding: const EdgeInsets.symmetric(
                          //                       horizontal: 25),
                          //                   child: Text(
                          //                     '₹${walletstate.walletAmount}',
                          //                     style: const TextStyle(
                          //                       fontSize: 24,
                          //                       fontWeight: FontWeight.bold,
                          //                       color: kGreenColour,
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ],
                          //             );
                          //           } else {
                          //             return Center(
                          //               child: LoadingAnimationWidget
                          //                   .staggeredDotsWave(
                          //                 color: kAppPrimaryColor,
                          //                 size: 40,
                          //               ),
                          //             );
                          //           }
                          //         },
                          //       );
                          //     } else {
                          //       return const Center(
                          //         child: SubHeadingTextWidget(
                          //             title: 'Wallet is empty'),
                          //       );
                          //     }
                          //   },
                          // ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SubHeadingTextWidget(
                              title: 'Discounted Amount:',
                              textsize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PriceTextWidget(
                              title: '₹${discountedAmount.floor()}',
                              textColor: kGreenColour,
                              textsize: 16,
                            ),
                          ),
                          kSizedBoxH10,
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SubHeadingTextWidget(
                              title: 'Payable Amount:',
                              textsize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PriceTextWidget(
                              title: '₹${payableAmount.floor()}',
                              textColor: kGreenColour,
                              textsize: 16,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButtonWidget(
                              buttonText: 'Place Order',
                              onPressed: () {
                                final selectedPaymentMethodId =
                                    BlocProvider.of<CheckoutBloc>(context).state
                                            is CheckoutLoaded
                                        ? (BlocProvider.of<CheckoutBloc>(
                                                    context)
                                                .state as CheckoutLoaded)
                                            .selectedPaymentMethodId
                                        : null;
                                if ((state.selectedAddressId == null ||
                                    state.selectedPaymentMethodId == null)) {
                                  showCustomSnackbar(
                                      context,
                                      'Please select an address and payment method',
                                      kRedColour,
                                      kwhiteColour);
                                  return;
                                }
                                final selectedPaymentMethod = checkoutData
                                    .paymentMethods
                                    .firstWhere((method) =>
                                        method.id == selectedPaymentMethodId);

                                if (selectedPaymentMethod.paymentName ==
                                    "Online Payment") {
                                  var options = {
                                    'method': {
                                      'netbanking': true,
                                      'card': true,
                                      'upi': true,
                                      'wallet': true,
                                    },
                                    'key': 'rzp_test_jVuUGTAIUk3lSH',
                                    'amount': payableAmount.round() * 100,
                                    'name': 'user',
                                    "entity": "order",
                                    "status": "created",
                                    "currency": "INR",
                                    //'order_id': 'order_EMBFqjDHEEn80l',
                                    "notes": [],
                                    'description': 'razorpay crocsclub',
                                    'timeout': 160,
                                    'prefill': {
                                      'contact': '8943936486',
                                      'email': 'user@gmail.com'
                                    }
                                  };
                                  _razorpay.open(options);
                                } else {
                                  BlocProvider.of<CheckoutBloc>(context)
                                      .add(PlaceOrder());
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                // else if (state is CheckoutOrderError) {
                //   return const Center(
                //       child: SubHeadingTextWidget(
                //     title: 'Order was not placed',
                //   ));
                // } else if (state is CheckoutSuccess) {
                //   return const Center(
                //       child: SubHeadingTextWidget(
                //           title: 'Order Placed Successfully!'));
                // }
                else {
                  return Center(
                    child: ElevatedButtonWidget(
                      buttonText: "Add Adress",
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AdressScreen(),
                        ));
                      },
                    ),
                  );
                  // Center(
                  //   child: LoadingAnimationWidget.staggeredDotsWave(
                  //     color: kAppPrimaryColor,
                  //     size: 40,
                  //   ),
                  // );
                }
              },
            );
          } else {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: kAppPrimaryColor,
                size: 40,
              ),
            );
          }
        },
      ),
    );
  }
}

Widget _buildAddressTile(BuildContext context, Address address) {
  return BlocProvider.value(
    value: BlocProvider.of<CheckoutBloc>(context),
    child: ListTile(
      title: SubHeadingTextWidget(
          textColor: kDarkGreyColour,
          textsize: 13,
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
          textsize: 13, textColor: kDarkGreyColour, title: method.paymentName),
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

Widget _buildCouponTile(
    BuildContext context, CouponModel coupon, double subtotal) {
  double additionalAmountNeeded = 0.0;
  if (subtotal < coupon.minimumPrice) {
    additionalAmountNeeded = coupon.minimumPrice - subtotal;
  }

  if (subtotal >= coupon.minimumPrice) {
    return BlocProvider.value(
      value: BlocProvider.of<CheckoutBloc>(context),
      child: ListTile(
        title: SubHeadingTextWidget(
          textsize: 13,
          textColor: kDarkGreyColour,
          title:
              '${coupon.name}  \nDiscount: ${coupon.discountPercentage}%\nmin price: ₹${coupon.minimumPrice}',
        ),
        trailing: Radio<int>(
          activeColor: kGreenColour,
          value: coupon.id,
          groupValue: BlocProvider.of<CheckoutBloc>(context).state
                  is CheckoutLoaded
              ? (BlocProvider.of<CheckoutBloc>(context).state as CheckoutLoaded)
                  .selectedCouponId
              : null,
          onChanged: (value) {
            BlocProvider.of<CheckoutBloc>(context)
                .add(SelectedCoupon(selectedCouponID: value!));
          },
        ),
      ),
    );
  } else {
    // Return ListTile with information about additional amount needed
    return ListTile(
      title: SubHeadingTextWidget(
        textsize: 13,
        textColor: kDarkGreyColour,
        title:
            '${coupon.name}  \nDiscount: ${coupon.discountPercentage}%\nmin price: ₹${coupon.minimumPrice}',
      ),
      trailing: SubHeadingTextWidget(
        textsize: 11,
        title:
            'Purchase for ₹${additionalAmountNeeded.floor()}\nto avail this coupon',
        textColor: kRedColour,
      ),
    );
  }
}
