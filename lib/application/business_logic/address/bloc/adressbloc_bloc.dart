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
      print('Adding Address - Loading...');
      emit(AdressblocLoading());
      try {
        final response = await adressservice.addAddress(event.addressDetails);
        if (response.statusCode == 200) {
          print('Address added successfully');
          emit(AddressAddedState('Address added successfully'));
        } else {
          final errorMessage =
              "Failed to add address: ${response.data['message']}";
          print(errorMessage);
          emit(AdressblocAddedError(errorMessage));
        }
      } catch (e) {
        final errorMessage = "Failed to add address: $e";
        print(errorMessage);
        emit(AdressblocAddedError(errorMessage));
      }
    });

    on<GetAddressEvent>((event, emit) async {
      print('Getting User Addresses - Loading...');
      emit(AdressblocLoading());
      try {
        final response = await adressservice.getUserAddresses();
        if (response.statusCode == 200) {
          final List<AddressModel> addresses = List<AddressModel>.from(response
              .data['data']
              .map((address) => AddressModel.fromJson(address)));
          print('User addresses retrieved successfully');
          emit(AdressblocLoaded(addressModel: addresses));
        } else {
          final errorMessage =
              "Failed to retrieve user addresses: ${response.data['message']}";
          print(errorMessage);
          emit(AdressblocError(errorMessage));
        }
      } catch (e) {
        final errorMessage = "Failed to retrieve user addresses: $e";
        print(errorMessage);
        emit(AdressblocError(errorMessage));
      }
    });
  }
}
