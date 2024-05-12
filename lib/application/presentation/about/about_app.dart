import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhiteColour,
      appBar: AppBar(
        centerTitle: true,
        title: const AppBarTextWidget(title: 'About Step In Style'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 220,
                child: Image.asset('assets/images/CROCS (2).png'),
              ),

              kSizedBoxH20,
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const SubHeadingTextWidget(
                  title:
                      'Welcome to Step In Style, your ultimate destination for comfortable and stylish footwear. We offer a wide range of high-quality footwearS designed to keep you comfortable throughout the day, whether you’re at home, work, or on an adventure.',
                  textColor: kDarkGreyColour,
                  textsize: 15,
                ),
              ),

              kSizedBoxH30,
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubHeadingTextWidget(
                      title: 'Features:',
                      textsize: 20,
                    ),
                    kSizedBoxH10,
                    SubHeadingTextWidget(
                      textColor: kDarkGreyColour,
                      title:
                          '- Shop the latest Footwear styles and collections',
                    ),
                    SubHeadingTextWidget(
                      textsize: 15,
                      textColor: kDarkGreyColour,
                      title: '- Find the perfect size of your choice',
                    ),
                    SubHeadingTextWidget(
                      textsize: 15,
                      textColor: kDarkGreyColour,
                      title: '- Save your favorite items to your wishlist',
                    ),
                    SubHeadingTextWidget(
                      textsize: 15,
                      textColor: kDarkGreyColour,
                      title:
                          '- Secure checkout process for hassle-free payments',
                    ),
                    SubHeadingTextWidget(
                      textsize: 15,
                      textColor: kDarkGreyColour,
                      title: '- Track your orders and view order history',
                    ),
                  ],
                ),
              ),

              kSizedBoxH30,

              // Contact information
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: BoxDecoration(
                  color: kGreyColour,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.email, color: kDarkGreyColour),
                    kSizedBoxW10,
                    Text(
                      'Contact us: kailaskailu56@gmail.com',
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
