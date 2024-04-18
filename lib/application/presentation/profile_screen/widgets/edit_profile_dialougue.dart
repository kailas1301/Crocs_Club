import 'package:crocs_club/application/business_logic/profile/bloc/profile_bloc.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/models/profile_model.dart';
import 'package:crocs_club/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocs_club/domain/utils/widgets/textformfield_widget.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileDialog extends StatelessWidget {
  final String initialEmail;
  final String initialName;
  final String initialPhone;

  const EditProfileDialog({
    Key? key,
    required this.initialEmail,
    required this.initialName,
    required this.initialPhone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: initialName);
    final TextEditingController emailController =
        TextEditingController(text: initialEmail);
    final TextEditingController phoneController =
        TextEditingController(text: initialPhone);

    return AlertDialog(
      title: const HeadingTextWidget(title: 'Edit Profile'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormFieldWidget(
              labelText: 'E-mail',
              controller: emailController,
              hintText: 'Enter your new E-mail',
              prefixIcon: Icons.email,
              validatorFunction: (value) {
                if (value == null || value.isEmpty) {
                  return 'E-mail is required';
                }
                final emailRegex = RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  caseSensitive: false,
                  multiLine: false,
                );
                if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid E-mail';
                }
                return null; // Valid
              },
            ),
            kSizedBoxH20, // Spacing
            // Password text field
            TextFormFieldWidget(
              labelText: 'Name',
              prefixIcon: Icons.person,
              controller: nameController,
              hintText: 'Enter your new Name',
              validatorFunction: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                if (value.length < 3) {
                  return 'Enter a valid name';
                }
                return null; // Valid
              },
            ),
            kSizedBoxH20,
            TextFormFieldWidget(
              labelText: 'Phone number',
              maxLength: 10,
              prefixIcon: Icons.call,
              controller: phoneController,
              hintText: 'Enter your new Phone No',
              validatorFunction: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phone No is required';
                }
                if (value.length < 10) {
                  return 'Phonenumber must be at least 10 characters long';
                }
                return null; // Valid
              },
            ), // Spacing
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButtonWidget(
          buttonText: 'Save',
          onPressed: () {
            BlocProvider.of<ProfileBloc>(context).add(
              ProfileEditRequested(
                editedProfile: UserProfile(
                  email: emailController.text,
                  name: nameController.text,
                  phone: phoneController.text,
                ),
              ),
            );
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
