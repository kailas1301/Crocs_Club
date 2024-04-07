import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget(
      {super.key,
      required this.onPressed,
      required this.buttonText,
      this.backgroundColor});
  final void Function() onPressed;
  final String buttonText;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SubHeadingTextWidget(
          title: buttonText,
          textColor: kblackColour,
        ),
      ),
    );
  }
}
