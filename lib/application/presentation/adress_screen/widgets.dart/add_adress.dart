import 'package:crocs_club/application/business_logic/address/bloc/adressbloc_bloc.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/functions/functions.dart';
import 'package:crocs_club/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocs_club/domain/utils/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crocs_club/domain/models/address_model.dart'; // Import your address model

class AddAddressScreen extends StatelessWidget {
  final TextEditingController cityController = TextEditingController();
  final TextEditingController houseNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController streetController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AddAddressScreen({super.key});

  String? _validateHouseName(String? value) {
    if (value == null || value.isEmpty) {
      return 'House name is required';
    }
    return null;
  }

  String? _validateStreet(String? value) {
    if (value == null || value.isEmpty) {
      return 'Street is required';
    }
    return null;
  }

  String? _validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'City is required';
    }
    return null;
  }

  String? _validateState(String? value) {
    if (value == null || value.isEmpty) {
      return 'State is required';
    }
    return null;
  }

  String? _validatePin(String? value) {
    if (value == null || value.isEmpty) {
      return 'PIN is required';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Address'),
      ),
      body: BlocListener<AdressblocBloc, AdressblocState>(
        listener: (context, state) {
          if (state is AddressAddedState) {
            houseNameController.clear;
            streetController.clear;
            cityController.clear;
            stateController.clear;
            pinController.clear;
            nameController.clear;
            phoneController.clear;
            showCustomSnackbar(context, 'Adress successfully added',
                kGreenColour, kblackColour);
          }
          if (state is AdressblocError) {
            showCustomSnackbar(context, 'Adress was not successfully added',
                kGreenColour, kblackColour);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormFieldWidget(
                  controller: houseNameController,
                  hintText: 'House Name',
                  validatorFunction: _validateHouseName,
                ),
                kSizedBoxH10,
                TextFormFieldWidget(
                  controller: streetController,
                  hintText: 'Street',
                  validatorFunction: _validateStreet,
                ),
                kSizedBoxH10,
                TextFormFieldWidget(
                  keyboardType: TextInputType.streetAddress,
                  controller: cityController,
                  hintText: 'City',
                  validatorFunction: _validateCity,
                ),
                kSizedBoxH10,
                TextFormFieldWidget(
                  keyboardType: TextInputType.name,
                  controller: stateController,
                  hintText: 'State',
                  validatorFunction: _validateState,
                ),
                kSizedBoxH10,
                TextFormFieldWidget(
                  keyboardType: TextInputType.number,
                  controller: pinController,
                  hintText: 'PIN',
                  validatorFunction: _validatePin,
                ),
                kSizedBoxH10,
                TextFormFieldWidget(
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  hintText: 'Name',
                  validatorFunction: _validateName,
                ),
                kSizedBoxH10,
                TextFormFieldWidget(
                  keyboardType: TextInputType.number,
                  controller: phoneController,
                  hintText: 'Phone',
                  validatorFunction: _validatePhone,
                ),
                kSizedBoxH20,
                ElevatedButtonWidget(
                  buttonText: 'Add Address',
                  backgroundColor: kblackColour,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final address = AddressModel(
                        city: cityController.text,
                        houseName: houseNameController.text,
                        name: nameController.text,
                        phone: phoneController.text,
                        pin: pinController.text,
                        state: stateController.text,
                        street: streetController.text,
                      );
                      // Dispatch AddAddressEvent
                      BlocProvider.of<AdressblocBloc>(context)
                          .add(AddAddressEvent(addressDetails: address));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
