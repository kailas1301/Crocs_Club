import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyContents extends StatelessWidget {
  const PrivacyContents({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
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
              'At StepSmart, we are committed to protecting your privacy and ensuring the security of your personal information.',
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
              '- Personal information such as name, email, address, and phone number provided during account registration or checkout process.',
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
        kSizedBoxH30,
        SubHeadingTextWidget(
          textsize: 15,
          textColor: kDarkGreyColour,
          title:
              'If you have any questions or concerns about our Privacy Policy, please contact us at kailaskailu56@gmail.com.',
        ),
        kSizedBoxH10,
        GestureDetector(
          onTap: () async {
            final Uri url = Uri.parse(
                'https://www.freeprivacypolicy.com/live/2de80a09-4255-4ef6-8cd0-ab3d22e57f4e');
            launchUrl(url);
          },
          child: SubHeadingTextWidget(
            textsize: 18,
            textColor: Colors.blue.shade700,
            title: ' Click here to view our Privacy Policy.',
          ),
        ),
      ],
    );
  }
}

Future<void> _launchUrl(dynamic url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
