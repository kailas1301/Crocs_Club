import 'package:crocs_club/application/business_logic/profile/bloc/profile_bloc.dart';
import 'package:crocs_club/application/presentation/adress_screen/adress_screen.dart';
import 'package:crocs_club/application/presentation/favourites_page/favourite_page.dart';
import 'package:crocs_club/application/presentation/orders/orders.dart';
import 'package:crocs_club/application/presentation/profile_screen/widgets/edit_profile_dialougue.dart';
import 'package:crocs_club/application/presentation/profile_screen/widgets/profile_screen_listtile_widget.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/functions/functions.dart';
import 'package:crocs_club/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileBloc>(context).add(ProfileFetched());
    return Scaffold(
      appBar: AppBar(
          centerTitle: true, title: const AppBarTextWidget(title: 'PROFILE')),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            showCustomSnackbar(context, 'User Details Successfully Updated',
                kGreenColour, kblackColour);
          }
        },
        builder: (context, state) {
          if (state is ProfileInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            final userDetails = state.profileData;
            String name = userDetails['name'];
            String email = userDetails['email'];
            String phone = userDetails['phone'];

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubHeadingTextWidget(
                      title: 'Name: $name',
                    ),
                    kSizedBoxH10,
                    SubHeadingTextWidget(
                      title: 'Email: $email',
                      textColor: kDarkGreyColour,
                    ),
                    kSizedBoxH10,
                    SubHeadingTextWidget(
                      title: 'Phone: $phone',
                      textColor: kDarkGreyColour,
                    ),
                    kSizedBoxH30,
                    ListTileWidget(
                      icon: Icons.edit,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => EditProfileDialog(
                            initialEmail: email,
                            initialName: name,
                            initialPhone: phone,
                          ),
                        );
                      },
                      title: 'Edit Profile',
                    ),
                    kSizedBoxH10,
                    ListTileWidget(
                      icon: Icons.favorite_outlined,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const FavouriteScreen(),
                        ));
                      },
                      title: 'Favorites',
                    ),
                    kSizedBoxH10,
                    ListTileWidget(
                      icon: Icons.shopping_cart,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const OrderScreen(),
                        ));
                      },
                      title: 'Orders',
                    ),
                    kSizedBoxH10,
                    ListTileWidget(
                      icon: Icons.location_on,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AdressScreen(),
                        ));
                      },
                      title: 'Addresses',
                    ),
                    kSizedBoxH30,
                    Center(
                      child: ElevatedButtonWidget(
                        onPressed: () {
                          userlogout(context);
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
