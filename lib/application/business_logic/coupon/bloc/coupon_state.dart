part of 'coupon_bloc.dart';

@immutable
sealed class CouponState {}

final class CouponInitial extends CouponState {}

class CouponLoading extends CouponState {}

class CouponLoaded extends CouponState {
  final List<CouponModel> coupons;

  CouponLoaded(this.coupons);
}

class CouponError extends CouponState {
  final String message;

  CouponError(this.message);
}