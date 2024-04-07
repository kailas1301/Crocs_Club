import 'package:bloc/bloc.dart';
import 'package:crocs_club/data/services/adress/adressrepo.dart';
import 'package:crocs_club/domain/models/address_model.dart';
import 'package:meta/meta.dart';

part 'adressbloc_event.dart';
part 'adressbloc_state.dart';

class AdressblocBloc extends Bloc<AdressblocEvent, AdressblocState> {
  final AdressServices adressservice = AdressServices();
  AdressblocBloc() : super(AdressblocInitial()) {
    on<AddAddressEvent>((event, emit) async {
      emit(AdressblocLoading());
      try {
        final response = await adressservice.addAddress(event.addressDetails);
        if (response.statusCode == 200) {
          emit(AddressAddedState('Address added successfully'));
        } else {
          emit(AdressblocError(
              "Failed to add address: ${response.data['message']}"));
        }
      } catch (e) {
        emit(AdressblocError("Failed to add address: $e"));
      }
    });

    on<GetAddressEvent>((event, emit) async {
      emit(AdressblocLoading());
      try {
        final response = await adressservice.getUserAddresses();
        if (response.statusCode == 200) {
          final List<AddressModel> addresses = List<AddressModel>.from(response
              .data['data']
              .map((address) => AddressModel.fromJson(address)));
          emit(AdressblocLoaded(addressModel: addresses));
        } else {
          emit(AdressblocError(
              "Failed to retrieve user addresses: ${response.data['message']}"));
        }
      } catch (e) {
        emit(AdressblocError("Failed to retrieve user addresses: $e"));
      }
    });
  }
}
