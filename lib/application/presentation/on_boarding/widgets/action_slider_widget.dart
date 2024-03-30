import 'package:action_slider/action_slider.dart';
import 'package:crocs_club/application/presentation/authentication_selecting/login/llogin_scrn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionSliderWidget extends StatelessWidget {
  const ActionSliderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ActionSlider.standard(
      toggleColor: const Color.fromARGB(255, 149, 147, 147),
      backgroundBorderRadius: BorderRadius.circular(35),
      child: Text(
        'Slide to confirm',
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
      ),
      action: (controller) async {
        controller.loading();
        await Future.delayed(const Duration(seconds: 3));
        controller.success();
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false,
        );
      },
    );
  }
}
