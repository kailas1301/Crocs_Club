import 'package:action_slider/action_slider.dart';
import 'package:concentric_transition/page_view.dart';
import 'package:crocs_club/presentation/authentication_selecting/llogin_scrn.dart';
import 'package:crocs_club/utils/constants.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final List<AssetImage> pages = [
    const AssetImage("assets/images/pngegg.png"),
    const AssetImage("assets/images/Green-Crocs-Transparent-Image.png"),
    const AssetImage("assets/images/crocs_PNG12.png"),
  ];
  final List<String> text = [
    'first page',
    'second page',
    'third page',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        itemCount: 3,
        reverse: false,
        radius: 10,
        verticalPosition: 0.85,
        colors: const [
          Color.fromARGB(255, 194, 197, 197),
          Color.fromARGB(255, 116, 116, 116),
          Color.fromARGB(255, 49, 49, 49)
        ],
        itemBuilder: (index) {
          int pageIndex = index % pages.length;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: pages[pageIndex], // Use AssetImage directly
                width: 350,
                height: 350,
              ),
              Text(text[pageIndex]),
              kSizedBoxH20,
              if (index == pages.length - 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: ActionSlider.standard(
                    toggleColor: Color.fromARGB(255, 149, 147, 147),
                    backgroundBorderRadius: BorderRadius.circular(35),
                    child: const Text('Slide to confirm'),
                    action: (controller) async {
                      controller.loading(); //starts loading animation
                      await Future.delayed(const Duration(seconds: 3));
                      controller.success();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    // ... other parameters for ActionSlider
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
