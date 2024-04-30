import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingAnimationStaggeredDotsWave extends StatelessWidget {
  const LoadingAnimationStaggeredDotsWave({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: kAppPrimaryColor,
        size: 40,
      ),
    );
  }
}

class ThreeDotLoadingAnimation extends StatelessWidget {
  const ThreeDotLoadingAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.threeRotatingDots(
            color: kAppPrimaryColor, size: 30));
  }
}
