import 'package:crocs_club/business_logic/profile/bloc/profile_bloc.dart';
import 'package:crocs_club/presentation/authentication_selecting/llogin_scrn.dart';
import 'package:crocs_club/utils/functions.dart';
import 'package:crocs_club/utils/widgets/elevatedbutton_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileBloc>(context).add(ProfileFetched());
    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ProfileInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoading) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Maintain loading indicator
          } else if (state is ProfileLoaded) {
            final userDetails = state.profileData;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display user details here
                Text('Name: ${userDetails['name']}'),
                Text('Email: ${userDetails['email']}'),
                Text('Phone: ${userDetails['phone']}'),
                ElevatedButtonWidget(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                          (route) => false);
                      userlogout(context);
                      showCustomSnackbar(context, 'Successfully logged out',
                          Colors.white, Colors.black);
                    },
                    buttonText: 'Log Out')
              ],
            );
          } else if (state is ProfileError) {
            return Center(child: Text('Error fetching data: ${state.error}'));
          } else {
            // Handle unexpected state types (optional)
            return const Text('Unknown state');
          }
        },
      ),
    );
  }
}
