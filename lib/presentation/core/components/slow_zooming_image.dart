import 'package:flutter/material.dart';

class SlowZoomingImage extends StatefulWidget {
  const SlowZoomingImage({
    super.key,
  });

  @override
  State<SlowZoomingImage> createState() => _SlowZoomingImageState();
}

class _SlowZoomingImageState extends State<SlowZoomingImage>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _animation;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _animation = Tween(begin: 1.0, end: 1.3).animate(_animationController);
    _animation.addListener(() {
      if (_animation.isCompleted) {
        _animationController.reverse();
      }
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return ClipRect(
          child: Transform(
            transform: Matrix4.diagonal3Values(
              _animation.value,
              _animation.value,
              1,
            ),
            alignment: FractionalOffset.center,
            child: Image.asset(
              "assets/images/party.jpg",
              height: 280,
              width: MediaQuery.of(context).size.width,
              cacheHeight: 300,
              cacheWidth: MediaQuery.of(context).size.width.toInt(),
              fit: BoxFit.fill,
            ),
          ),
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
