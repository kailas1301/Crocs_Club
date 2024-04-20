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

class PlaceOrder extends CheckoutEvent {}
