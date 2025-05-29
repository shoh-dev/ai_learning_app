import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class LottieLoading extends StatelessWidget {
  const LottieLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: .8,
      child: Lottie.asset(
        'assets/animations/anim_lottie6.json',
        addRepaintBoundary: true,
      ),
    );
  }
}
