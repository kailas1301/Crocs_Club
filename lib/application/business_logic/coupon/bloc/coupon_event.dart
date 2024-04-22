part of 'coupon_bloc.dart';

@immutable
sealed class CouponEvent {}

class LoadCouponsEvent extends CouponEvent {}
