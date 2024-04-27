import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/models/address_model.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';

class AdressCard extends StatelessWidget {
  const AdressCard({
    super.key,
    required this.address,
    required this.index,
  });

  final AddressModel address;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kwhiteColour,
      elevation: 4,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: kPrimaryDarkColor,
            radius: 30,
            child: Icon(
              Icons.location_on,
              size: 25,
              color: kwhiteColour,
            ),
          ),
          title: SubHeadingTextWidget(
              textsize: 16,
              textColor: kblackColour,
              title: 'Address ${index + 1}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubHeadingTextWidget(
                  textsize: 14,
                  textColor: kDarkGreyColour,
                  title: 'Name: ${address.name}'),
              SubHeadingTextWidget(
                  textsize: 14,
                  textColor: kDarkGreyColour,
                  title: '${address.houseName} House, ${address.street}'),
              SubHeadingTextWidget(
                  textsize: 14,
                  textColor: kDarkGreyColour,
                  title: '${address.city}, ${address.state} - ${address.pin}'),
              SubHeadingTextWidget(
                  textsize: 14,
                  textColor: kDarkGreyColour,
                  title: 'Phone: ${address.phone}'),
            ],
          ),
        ),
      ),
    );
  }
}
