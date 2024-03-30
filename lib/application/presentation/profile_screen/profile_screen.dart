import 'package:crocs_club/application/business_logic/profile/bloc/profile_bloc.dart';
import 'package:crocs_club/application/presentation/authentication_selecting/login/llogin_scrn.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/functions/functions.dart';
import 'package:crocs_club/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileBloc>(context).add(ProfileFetched());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ProfileInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            final userDetails = state.profileData;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${userDetails['name']}',
                      style: GoogleFonts.openSans(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Email: ${userDetails['email']}',
                      style: GoogleFonts.openSans(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Phone: ${userDetails['phone']}',
                      style: GoogleFonts.openSans(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 24.0),
                    ListTile(
                      leading: const Icon(Icons.favorite),
                      title: Text(
                        'Favorites',
                        style: GoogleFonts.poppins(
                            fontSize: 18.0, fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        // Navigate to favorites screen
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.shopping_cart),
                      title: Text(
                        'Orders',
                        style: GoogleFonts.poppins(
                            fontSize: 18.0, fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        // Navigate to orders screen
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.location_on),
                      title: Text(
                        'Addresses',
                        style: GoogleFonts.poppins(
                            fontSize: 18.0, fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        // Navigate to addresses screen
                      },
                    ),
                    const Divider(),
                    kSizedBoxH30,
                    Center(
                      child: ElevatedButtonWidget(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                          userlogout(context);
                          showCustomSnackbar(context, 'Successfully logged out',
                              Colors.white, Colors.black);
                        },
                        buttonText: 'Log Out',
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ProfileError) {
            return Center(
              child: Text('Error fetching data: ${state.error}'),
            );
          } else {
            return const Text('Unknown state');
          }
        },
      ),
    );
  }
}
