part of 'checkout_bloc.dart';

@immutable
sealed class CheckoutEvent {}

class LoadCheckoutDetails extends CheckoutEvent {}

class SelectAddress extends CheckoutEvent {
  final int addressId;
  SelectAddress({required this.addressId});
}

class SelectPaymentMethod extends CheckoutEvent {
  final int paymentMethodId;
  SelectPaymentMethod({required this.paymentMethodId});
}

class SelectedCoupon extends CheckoutEvent {
  final int selectedCouponID;
  SelectedCoupon({required this.selectedCouponID});
}

class SelectWallet extends CheckoutEvent {
  final bool useWallet;
  SelectWallet({required this.useWallet});
}

class PlaceOrder extends CheckoutEvent {}

class PaymentSuccess extends CheckoutEvent {}

class PaymentError extends CheckoutEvent {}
