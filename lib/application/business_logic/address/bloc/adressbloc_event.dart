part of 'adressbloc_bloc.dart';

@immutable
sealed class AdressblocEvent {}

final class GetAddressEvent extends AdressblocEvent {}

final class AddAddressEvent extends AdressblocEvent {
  final AddressModel addressDetails;

  AddAddressEvent({required this.addressDetails});
}
