import 'package:bloc/bloc.dart';
import 'package:crocs_club/data/services/coupon/coupon.dart';
import 'package:crocs_club/domain/models/coupon_model.dart';
import 'package:meta/meta.dart';

part 'coupon_event.dart';
part 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponServices couponServices = CouponServices();
  CouponBloc() : super(CouponInitial()) {
    on<LoadCouponsEvent>((event, emit) async {
      try {
        final coupons = await couponServices.getCoupons();
        emit(CouponLoaded(coupons));
      } catch (error) {
        emit(CouponError(error.toString()));
      }
    });
  }
}
