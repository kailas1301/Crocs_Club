import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;

  const ListTileWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kblackColour,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: ListTile(
          leading: Icon(
            icon,
            color: kwhiteColour,
          ),
          title: SubHeadingTextWidget(
            title: title,
            textColor: kwhiteColour,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
