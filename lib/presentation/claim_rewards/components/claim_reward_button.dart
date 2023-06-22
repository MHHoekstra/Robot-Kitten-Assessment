import 'package:flutter/material.dart';
import 'package:robot_kitten_assessment/presentation/core/design_system/app_fonts.dart';

import '../../core/design_system/app_colors.dart';

class ClaimRewardButton extends StatefulWidget {
  final double width;
  final VoidCallback onSecondTap;
  final double height;

  const ClaimRewardButton({
    super.key,
    required this.onSecondTap,
    required this.height,
    required this.width,
  });

  @override
  State<ClaimRewardButton> createState() => _ClaimRewardButtonState();
}

class _ClaimRewardButtonState extends State<ClaimRewardButton>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );
  late final AnimationController _secondTapController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 300,
    ),
  );

  late final Animation<double> _secondTapAnimation =
      Tween<double>(begin: 1, end: 0.11).animate(
    CurvedAnimation(parent: _secondTapController, curve: Curves.easeInOut),
  );

  late final Animation<double> _redAnimation =
      Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.0,
        0.5,
        curve: Curves.ease,
      ),
    ),
  );

  late final Animation<double> _claimAnimation =
      Tween<double>(begin: 0, end: -widget.height).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.5,
        0.8,
        curve: Curves.ease,
      ),
    ),
  );

  late final Animation<double> _whiteAnimation =
      Tween<double>(begin: widget.height, end: 0).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.6,
        1,
        curve: Curves.ease,
      ),
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (_controller.isCompleted) {
          _secondTapController.forward();
        } else {
          _controller.forward();
        }
      },
      onTapUp: (_) {
        if (_controller.isCompleted) {
          Future.delayed(const Duration(milliseconds: 200)).then((value) {
            _secondTapController.reverse();
            widget.onSecondTap();
          });
        }
      },
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _redAnimation,
          _whiteAnimation,
          _claimAnimation,
          _secondTapAnimation,
        ]),
        builder: (context, _) => Opacity(
          opacity: _secondTapAnimation.value,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.white,
                ),
                bottom: BorderSide(
                  color: AppColors.white,
                ),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.scale(
                  alignment: Alignment.centerLeft,
                  scaleX: _redAnimation.value,
                  child: Container(
                    color: AppColors.red,
                  ),
                ),
                Positioned(
                  bottom: _claimAnimation.value,
                  child: Container(
                    height: widget.height,
                    alignment: Alignment.center,
                    child: Text(
                      "CLAIM REWARD",
                      style: AppFonts.button.copyWith(color: AppColors.white),
                    ),
                  ),
                ),
                Positioned(
                  top: _whiteAnimation.value,
                  width: widget.width,
                  height: widget.height,
                  child: Container(
                    color: AppColors.white,
                  ),
                ),
                Positioned(
                  bottom: _whiteAnimation.value,
                  child: Container(
                    height: widget.height,
                    alignment: Alignment.center,
                    child: const Text(
                      "OPEN MAIL APP",
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        fontFamily: "Druk",
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
