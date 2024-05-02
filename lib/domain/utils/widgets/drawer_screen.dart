import 'package:crocs_club/application/presentation/about/about_app.dart';
import 'package:crocs_club/application/presentation/favourites_page/favourite_page.dart';
import 'package:crocs_club/application/presentation/privacy/privacy_insights.dart';
import 'package:crocs_club/application/presentation/profile_screen/profile_screen.dart';
import 'package:crocs_club/application/presentation/wallet/wallet_screen.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/functions/functions.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          kSizedBoxH30,
          kSizedBoxH30,
          ListTile(
            leading: const Icon(Icons.person),
            title: const SubHeadingTextWidget(
                textColor: kDarkGreyColour, title: 'Profile', textsize: 15),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const SubHeadingTextWidget(
              textColor: kDarkGreyColour,
              title: 'Favourites',
              textsize: 15,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const FavouriteScreen(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.currency_rupee_rounded),
            title: const SubHeadingTextWidget(
              textColor: kDarkGreyColour,
              title: 'Wallet',
              textsize: 15,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const WalletScreen(),
              ));
            },
          ),
          ListTile(
              leading: const Icon(Icons.logout),
              title: const SubHeadingTextWidget(
                  textColor: kDarkGreyColour, title: 'Log Out', textsize: 15),
              onTap: () {
                userlogout(context);
              }),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const SubHeadingTextWidget(
                textColor: kDarkGreyColour,
                title: 'Privacy Insights',
                textsize: 15),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const PrivacyPolicyPage(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const SubHeadingTextWidget(
                textColor: kDarkGreyColour, title: 'About Us', textsize: 15),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AboutPage(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
