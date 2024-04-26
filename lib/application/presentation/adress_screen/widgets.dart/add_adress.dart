import 'package:crocs_club/application/business_logic/address/bloc/adressbloc_bloc.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/functions/functions.dart';
import 'package:crocs_club/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocs_club/domain/utils/widgets/textformfield_widget.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crocs_club/domain/models/address_model.dart'; // Import your address model

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController cityController = TextEditingController();
    final TextEditingController houseNameController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController pinController = TextEditingController();
    final TextEditingController stateController = TextEditingController();
    final TextEditingController streetController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppBarTextWidget(title: 'Add Address'),
      ),
      body: BlocListener<AdressblocBloc, AdressblocState>(
        listener: (context, state) {
          if (state is AddressAddedState) {
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
            key: formKey,
            child: ListView(
              children: [
                TextFormFieldWidget(
                  keyboardType: TextInputType.name,
                  labelText: 'House Name',
                  controller: houseNameController,
                  hintText: 'Enter house name',
                  validatorFunction: _validateHouseName,
                ),
                kSizedBoxH10,
                TextFormFieldWidget(
                  labelText: 'Street Name',
                  controller: streetController,
                  hintText: 'Enter name of your street',
                  validatorFunction: _validateStreet,
                ),
                kSizedBoxH10,
                TextFormFieldWidget(
                  labelText: 'City',
                  keyboardType: TextInputType.streetAddress,
                  controller: cityController,
                  hintText: 'Enter name of your city',
                  validatorFunction: _validateCity,
                ),
                kSizedBoxH10,
                TextFormFieldWidget(
                  labelText: 'State',
                  keyboardType: TextInputType.name,
                  controller: stateController,
                  hintText: 'Enter name of your State',
                  validatorFunction: _validateState,
                ),
                kSizedBoxH10,
                TextFormFieldWidget(
                  labelText: 'PIN-code',
                  keyboardType: TextInputType.number,
                  controller: pinController,
                  hintText: 'Enter your PIN-code',
                  validatorFunction: _validatePin,
                ),
                kSizedBoxH10,
                TextFormFieldWidget(
                  labelText: 'Name',
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  hintText: 'Enter your Name',
                  validatorFunction: _validateName,
                ),
                kSizedBoxH10,
                TextFormFieldWidget(
                  labelText: 'Phone No',
                  keyboardType: TextInputType.number,
                  controller: phoneController,
                  hintText: 'Enter your Phone number',
                  validatorFunction: _validatePhone,
                ),
                kSizedBoxH20,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButtonWidget(
                    buttonText: 'Add Address',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final address = AddressModel(
                          city: cityController.text,
                          houseName: houseNameController.text,
                          name: nameController.text,
                          phone: phoneController.text,
                          pin: pinController.text,
                          state: stateController.text,
                          street: streetController.text,
                        );
                        BlocProvider.of<AdressblocBloc>(context)
                            .add(AddAddressEvent(addressDetails: address));
                        houseNameController.clear;
                        streetController.clear;
                        cityController.clear;
                        stateController.clear;
                        pinController.clear;
                        nameController.clear;
                        phoneController.clear;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
}
