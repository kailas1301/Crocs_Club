import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';

class PrivacyContents extends StatelessWidget {
  const PrivacyContents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubHeadingTextWidget(
          textsize: 18,
          title: 'Our Commitment to Privacy:',
        ),
        kSizedBoxH10,
        SubHeadingTextWidget(
          textsize: 15,
          textColor: kDarkGreyColour,
          title:
              'At CrocsClub, we are committed to protecting your privacy and ensuring the security of your personal information.',
        ),
        SizedBox(height: 20),
        SubHeadingTextWidget(
          textsize: 18,
          title: 'What Information We Collect:',
        ),
        kSizedBoxH10,
        SubHeadingTextWidget(
          textsize: 15,
          textColor: kDarkGreyColour,
          title:
              'We may collect various types of information from users, including:',
        ),
        SubHeadingTextWidget(
          textsize: 15,
          textColor: kDarkGreyColour,
          title:
              '- Personal information such as name, email address, and phone number provided during account registration or checkout process.',
        ),
        kSizedBoxH20,
        SubHeadingTextWidget(
          textsize: 18,
          title: 'How We Use Your Information:',
        ),
        kSizedBoxH10,
        SubHeadingTextWidget(
          textsize: 15,
          textColor: kDarkGreyColour,
          title:
              'We may use the information we collect for various purposes, including:',
        ),
        SubHeadingTextWidget(
          textsize: 15,
          textColor: kDarkGreyColour,
          title: '- Processing and fulfilling orders',
        ),
        SubHeadingTextWidget(
          textsize: 15,
          textColor: kDarkGreyColour,
          title: '- Providing customer support and responding to inquiries',
        ),
        SubHeadingTextWidget(
          textsize: 15,
          textColor: kDarkGreyColour,
          title: '- Personalizing user experience and improving our services',
        ),
        kSizedBoxH20,
        SubHeadingTextWidget(
          textsize: 18,
          title: 'How We Protect Your Information:',
        ),
        kSizedBoxH10,
        SubHeadingTextWidget(
          textsize: 15,
          textColor: kDarkGreyColour,
          title:
              'We implement various security measures to safeguard your personal information, including encryption, access controls, and regular security audits.',
        ),
        kSizedBoxH20,
        SubHeadingTextWidget(
          textsize: 18,
          title: 'Contact Us:',
        ),
        kSizedBoxH10,
        SubHeadingTextWidget(
          textsize: 15,
          textColor: kDarkGreyColour,
          title:
              'If you have any questions or concerns about our Privacy Policy, please contact us at crocsclub2024@gmail.com.',
        ),
      ],
    );
  }
}
