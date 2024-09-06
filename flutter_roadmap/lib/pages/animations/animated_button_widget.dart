import 'package:flutter/material.dart';

class AnimatedButtonWidget extends StatefulWidget {
  const AnimatedButtonWidget({super.key});

  @override
  State<AnimatedButtonWidget> createState() => _AnimatedButtonWidgetState();
}

class _AnimatedButtonWidgetState extends State<AnimatedButtonWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2))..repeat();

    _animation = Tween<double>(begin: 2.0, end: 10.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ButtonWidget(
        animation: _animation,
      ),
    );
  }
}

class ButtonWidget extends AnimatedWidget {
  final Animation<double> animation;
  ButtonWidget({
    Key? key,
    required this.animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final borderWidth = (listenable as Animation<double>).value;

    return OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: Colors.blue,
            width: borderWidth, // 动态变化的边框宽度
          ),
        ),
        child: const Text('Click Me!'));
  }
}
