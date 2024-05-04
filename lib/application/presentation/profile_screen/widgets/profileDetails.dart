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

class ProfileDetailsWidget extends StatelessWidget {
  const ProfileDetailsWidget({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
  });

  final String name;
  final String email;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
