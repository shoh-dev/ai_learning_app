import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lottie/lottie.dart';
import 'package:myspace_ui/myspace_ui.dart';

class LottieCircleAvatar extends StatefulWidget {
  const LottieCircleAvatar({super.key});

  @override
  State<LottieCircleAvatar> createState() => _LottieCircleAvatarState();
}

class _LottieCircleAvatarState extends State<LottieCircleAvatar>
    with SingleTickerProviderStateMixin {
  late final AnimationController lottieController;

  @override
  void initState() {
    lottieController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );
    super.initState();
  }

  @override
  void dispose() {
    if (lottieController.isAnimating) {
      lottieController.stop();
      lottieController.dispose();
    } else {
      lottieController.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return GestureDetector(
          onTap: () {
            context.unfocus();
            if (lottieController.isAnimating) return;
            lottieController.reverse().then((value) {
              lottieController.forward();
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: double.infinity,
            height: isKeyboardVisible ? 180 : 300,
            child: Lottie.asset(
              'assets/animations/anim_lottie4.json',
              controller: lottieController,
              onLoaded: (p0) {
                // Configure the AnimationController with the duration of the
                // Lottie file and start the animation.
                lottieController.forward();
              },
              addRepaintBoundary: true,
            ),
          ),
        );
      },
    );
  }
}
