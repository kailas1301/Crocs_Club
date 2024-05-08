import 'package:crocs_club/application/business_logic/profile/bloc/profile_bloc.dart';
import 'package:crocs_club/application/presentation/profile_screen/widgets/profileDetails.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/functions/functions.dart';
import 'package:crocs_club/domain/utils/widgets/loading_animations.dart';
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
          centerTitle: true, title: const AppBarTextWidget(title: 'Profile')),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            showCustomSnackbar(context, 'User Details Successfully Updated',
                kGreenColour, kblackColour);
          }
        },
        builder: (context, state) {
          if (state is ProfileInitial) {
            return const LoadingAnimationStaggeredDotsWave();
          } else if (state is ProfileLoading) {
            return const LoadingAnimationStaggeredDotsWave();
          } else if (state is ProfileLoaded) {
            final userDetails = state.profileData;
            String name = userDetails['name'];
            String email = userDetails['email'];
            String phone = userDetails['phone'];

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProfileDetailsWidget(
                    name: name, email: email, phone: phone),
              ),
            );
          } else if (state is ProfileError) {
            return const Center(
              child: SubHeadingTextWidget(
                title: 'No Data found',
                textsize: 16,
              ),
            );
          } else {
            return const Center(
              child: SubHeadingTextWidget(
                title: 'No Data found',
                textsize: 16,
              ),
            );
          }
        },
      ),
    );
  }
}
