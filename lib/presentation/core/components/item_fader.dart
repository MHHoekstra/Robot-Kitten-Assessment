import 'package:flutter/material.dart';

class ItemFader extends StatefulWidget {
  final Widget child;
  final bool translateOnShow;
  final bool translateOnHide;

  const ItemFader({
    Key? key,
    required this.child,
    this.translateOnShow = true,
    this.translateOnHide = true,
  }) : super(key: key);

  @override
  State<ItemFader> createState() => ItemFaderState();
}

class ItemFaderState extends State<ItemFader>
    with SingleTickerProviderStateMixin {
  double position = -1;
  late final AnimationController _animationController;
  late final Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 600,
      ),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  void show() {
    setState(() {
      position = 1;
    });
    _animationController.forward();
  }

  void hide() {
    setState(() {
      position = -1;
    });
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            widget.translateOnHide && position == -1
                ? 64 * position * (1 - _animation.value)
                : widget.translateOnShow && position == 1
                    ? 64 * position * (1 - _animation.value)
                    : 0,
          ),
          child: Opacity(opacity: _animation.value, child: widget.child),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
