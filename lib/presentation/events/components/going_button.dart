import 'package:flutter/material.dart';
import 'package:robot_kitten_assessment/presentation/core/design_system/app_colors.dart';
import 'package:robot_kitten_assessment/presentation/core/design_system/app_fonts.dart';

class GoingButton extends StatefulWidget {
  final Function(bool) onTap;
  final bool initialValue;
  const GoingButton({
    super.key,
    required this.onTap,
    required this.initialValue,
  });

  @override
  State<GoingButton> createState() => _GoingButtonState();
}

class _GoingButtonState extends State<GoingButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  final ColorTween _textColor = ColorTween(
    begin: AppColors.white,
    end: AppColors.black,
  );

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
    );
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
        builder: (BuildContext context, Widget? child) {
          return Stack(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 55,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.white),
                  bottom: BorderSide(color: AppColors.white),
                ),
              ),
            ),
            Transform.scale(
              alignment: Alignment.centerLeft,
              scaleX: _animation.value,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 55,
                color: AppColors.white,
              ),
            ),
            Container(
              height: 55,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: _animation.value,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.check_circle_outline,
                        color: _textColor.evaluate(_animation),
                        size: 24,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset((1 - _animation.value) * -16, 0),
                    child: Text(
                      "GOING",
                      style: AppFonts.button.copyWith(
                        color: _textColor.evaluate(
                          _animation,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]);
        },
      ),
    );
  }
}
