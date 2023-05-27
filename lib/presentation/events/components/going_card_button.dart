import 'package:flutter/material.dart';
import 'package:robot_kitten_assessment/presentation/core/design_system/app_colors.dart';
import 'package:robot_kitten_assessment/presentation/core/design_system/app_fonts.dart';

class GoingCardButton extends StatefulWidget {
  final Function(bool) onTap;
  final bool initialValue;

  const GoingCardButton({
    super.key,
    required this.onTap,
    required this.initialValue,
  });

  @override
  State<GoingCardButton> createState() => _GoingCardButtonState();
}

class _GoingCardButtonState extends State<GoingCardButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  final ColorTween _colorTween =
      ColorTween(begin: AppColors.white, end: AppColors.black);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );
    if (widget.initialValue) {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_animationController.isCompleted) {
          _animationController.reverse();
          widget.onTap(false);
        } else {
          _animationController.forward();
          widget.onTap(true);
        }
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) => SizedBox(
          height: 33,
          width: 131,
          child: Stack(
            children: [
              Container(
                height: 33,
                width: 131,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.white,
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: _animation.value,
                        child: const Icon(
                          Icons.check_circle_outline,
                          color: AppColors.black,
                          size: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Transform.translate(
                        offset: Offset((1 - _animation.value) * -8, 0),
                        child: Text(
                          "Going",
                          style: AppFonts.h4.copyWith(
                            color: _colorTween.evaluate(_animation),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Transform.scale(
                scaleX: _animation.value,
                alignment: Alignment.centerLeft,
                child: Ink(
                  height: 33,
                  width: 131,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
