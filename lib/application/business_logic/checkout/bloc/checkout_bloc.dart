import 'package:bloc/bloc.dart';
import 'package:crocs_club/data/services/coupon/coupon.dart';
import 'package:crocs_club/data/services/get_checkout/get_checkout.dart';
import 'package:crocs_club/data/sharedpreference/shared_preference.dart';
import 'package:crocs_club/domain/models/checkout_details.dart';
import 'package:crocs_club/domain/models/coupon_model.dart';
import 'package:crocs_club/domain/models/order.dart';
import 'package:meta/meta.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckOutServices checkoutRepository = CheckOutServices();
  CouponServices couponServices = CouponServices();

  CheckoutBloc(this.checkoutRepository) : super(CheckoutLoading()) {
    on<LoadCheckoutDetails>(_onLoadCheckoutDetails);
    on<SelectAddress>(_onSelectAddress);
    on<SelectPaymentMethod>(_onSelectPaymentMethod);
    on<SelectedCoupon>(_onSelectCoupon);
    on<PlaceOrder>(_onPlaceOrder);
  }

  void _onLoadCheckoutDetails(
      CheckoutEvent event, Emitter<CheckoutState> emit) async {
    try {
      final coupons = await couponServices.getCoupons();
      final checkoutData = await checkoutRepository.fetchCheckoutDetails();
      emit(CheckoutLoaded(checkoutData: checkoutData, coupons: coupons));
    } catch (error) {
      emit(CheckoutError(error.toString()));
    }
  }

  void _onSelectAddress(
      CheckoutEvent event, Emitter<CheckoutState> emit) async {
    final selectedAddressId = (event as SelectAddress).addressId;
    final currentState = state as CheckoutLoaded;
    final coupons = await couponServices.getCoupons();
    emit(CheckoutLoaded(
        coupons: coupons,
        checkoutData: currentState.checkoutData,
        selectedAddressId: selectedAddressId,
        selectedPaymentMethodId: currentState.selectedPaymentMethodId,
        selectedCouponId: currentState.selectedCouponId));
  }

  void _onSelectPaymentMethod(
      CheckoutEvent event, Emitter<CheckoutState> emit) async {
    final selectedPaymentMethodId =
        (event as SelectPaymentMethod).paymentMethodId;
    final currentState = state as CheckoutLoaded;
    final coupons = await couponServices.getCoupons();
    emit(CheckoutLoaded(
        coupons: coupons,
        checkoutData: currentState.checkoutData,
        selectedAddressId: currentState.selectedAddressId,
        selectedPaymentMethodId: selectedPaymentMethodId,
        selectedCouponId: currentState.selectedCouponId));
  }

  void _onSelectCoupon(CheckoutEvent event, Emitter<CheckoutState> emit) async {
    final selectcoupoId = (event as SelectedCoupon).selectedCouponID;
    final currentstate = state as CheckoutLoaded;
    final coupons = await couponServices.getCoupons();
    emit(CheckoutLoaded(
        coupons: coupons,
        checkoutData: currentstate.checkoutData,
        selectedAddressId: currentstate.selectedAddressId,
        selectedPaymentMethodId: currentstate.selectedPaymentMethodId,
        selectedCouponId: selectcoupoId));
  }

  void _onPlaceOrder(CheckoutEvent event, Emitter<CheckoutState> emit) async {
    final currentState = state as CheckoutLoaded;
    if (currentState.selectedAddressId == null ||
        currentState.selectedPaymentMethodId == null) {
      emit(CheckoutError('Please select an address and payment method'));
      return;
    }
    try {
      final userId = await getUserId();
      final orderDetails = OrderDetails(
        addressId: currentState.selectedAddressId!,
        couponId: currentState.selectedCouponId!,
        paymentId: currentState.selectedPaymentMethodId!,
        useWallet: false,
        userId: userId ?? 0,
      );

      final response = await checkoutRepository.placeOrder(orderDetails);
      if (response == 200) {
        emit(CheckoutSuccess());
      } else {
        emit(CheckoutOrderError('failed to place order'));
      }
    } catch (error) {
      emit(CheckoutOrderError(error.toString()));
    }
  }
}
