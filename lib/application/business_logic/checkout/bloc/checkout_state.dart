part of 'checkout_bloc.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  final CheckoutData checkoutData;
  final List<CouponModel>? coupons;
  final int? selectedAddressId;
  final int? selectedPaymentMethodId;
  final int? selectedCouponId;
  final bool? useWallet;

  CheckoutLoaded({
    this.useWallet,
    this.selectedCouponId,
    required this.checkoutData,
    this.coupons,
    this.selectedAddressId,
    this.selectedPaymentMethodId,
  });
}

class CheckoutError extends CheckoutState {
  final String errorMessage;

  CheckoutError(this.errorMessage);
}

class CheckoutSuccess extends CheckoutState {}

class CheckoutOrderError extends CheckoutState {
  final String errorMessage;

  CheckoutOrderError(this.errorMessage);
}

class Paymentfinished extends CheckoutState {}

class Paymenterror extends CheckoutState {}
