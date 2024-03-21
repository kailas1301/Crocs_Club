import 'package:crocs_club/utils/constants.dart';
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
          SizedBox(
            child: Center(
              child: Text('USERNAME'),
            ),
          ),
          kSizedBoxH30,
          ListTile(
            leading:
                const Icon(Icons.person), // Leading widget for this list tile
            title: const Text('Profile'),
            onTap: () {
              // Handle navigation to home
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.favorite), // Leading widget for this list tile
            title: const Text('Favourites'),
            onTap: () {
              // Handle navigation to settings
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.logout), // Leading widget for this list tile
            title: const Text('Log Out'),
            onTap: () {
              // Handle navigation to settings
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.share), // Leading widget for this list tile
            title: const Text('Share'),
            onTap: () {
              // Handle navigation to settings
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.info), // Leading widget for this list tile
            title: const Text('About Us'),
            onTap: () {
              // Handle navigation to settings
            },
          ),
        ],
      ),
    );
  }
}
