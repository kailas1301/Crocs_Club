import 'package:concentric_transition/page_view.dart';
import 'package:crocs_club/application/presentation/on_boarding/widgets/action_slider_widget.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/application/presentation/on_boarding/widgets/container_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final List<String> pages = [
    "assets/images/onboarding1.jpg",
    "assets/images/onboarding2.jpg",
    "assets/images/onboarding3.jpg",
  ];
  final List<String> text = [
    'Welcome to Crocs Club',
    'Step into comfort and style with Crocs Club!',
    'Unleash your style potential with Crocs',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        itemCount: 3,
        reverse: false,
        radius: 5,
        verticalPosition: 0.85,
        colors: const [
          Color.fromARGB(255, 227, 230, 230),
          Color.fromARGB(255, 192, 190, 190),
          Color.fromARGB(255, 152, 150, 150)
        ],
        itemBuilder: (index) {
          int pageIndex = index % pages.length;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ContainerWithImage(imagePath: pages[pageIndex]),
              kSizedBoxH10,
              Text(text[pageIndex],
                  style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w700, fontSize: 16)),
              kSizedBoxH10,
              if (index == pages.length - 1)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: ActionSliderWidget(),
                ),
            ],
          );
        },
      ),
    );
  }
}
