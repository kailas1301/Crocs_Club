// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// part 'razorpay_event.dart';
// part 'razorpay_state.dart';

// class RazorpayBloc extends Bloc<RazorpayEvent, RazorpayState> {
//   Razorpay razorpay = Razorpay();

//   RazorpayBloc() : super(RazorpayInitial()) {
//     on<InitiateRazorPayPayment>((event, emit) async {
//       emit(RazorpayLoading());
//       try {
//         var options = {
//           'key': 'YOUR_RAZORPAY_KEY_ID',
//           'amount': int.parse(event.amount) * 100,
//           'currency': "INR",
//           'name': 'Crocs Club',
//           'description': 'Order Payment',
//           'orderId': "",
//         };

//         razorpay.open(options);
//         razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
//             (PaymentSuccessResponse response) {
//           emit(RazorpaySuccess(message: 'Payment successful'));
//         });
//         razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
//             (PaymentFailureResponse response) {
//           emit(RazorpayFailure(message: 'Payment failed: ${response.message}'));
//         });
//         razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
//             (ExternalWalletResponse response) {
//           emit(RazorpayFailure(message: 'Payment using external wallet'));
//         });
//       } catch (error) {
//         emit(RazorpayFailure(message: error.toString()));
//       }
//     });
//   }

//   @override
//   Future<void> close() {
//     razorpay.clear();
//     return super.close();
//   }
// }
