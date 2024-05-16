part of 'adressbloc_bloc.dart';

@immutable
sealed class AdressblocState {}

final class AdressblocInitial extends AdressblocState {}

final class AdressblocLoading extends AdressblocState {}

class AddressAddedState extends AdressblocState {
  final String message;

  AddressAddedState(this.message);
}

final class AdressblocLoaded extends AdressblocState {
  final List<AddressModel> addressModel;
  AdressblocLoaded({required this.addressModel});
}

final class AdressblocError extends AdressblocState {
  final String message;

  AdressblocError(this.message);
}

final class AdressblocAddedError extends AdressblocState {
  final String message;

  AdressblocAddedError(this.message);
}
