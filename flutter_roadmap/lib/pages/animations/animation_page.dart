import 'package:flutter/material.dart';
import 'package:flutter_roadmap/pages/animations/ScaleAnimationDemo.dart';
import 'package:flutter_roadmap/pages/animations/animated_button_widget.dart';
import 'package:flutter_roadmap/pages/animations/animation_builder_demo.dart';
import 'package:flutter_roadmap/pages/animations/hero_animation_page.dart';
import 'package:flutter_roadmap/pages/animations/tween_widget.dart';

import '../state_management/state_management_page.dart';
import 'animated_logo_widget.dart';

class AnimationPage extends StatelessWidget {
  const AnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Item> data = [
      const Item(title: 'Tween', widget: TweenWidget()),
      const Item(title: 'Animated Logo and listener', widget: AnimatedLogoWidget()),
      const Item(title: 'Animated Builder Demo', widget: AnimationBuilderDemo()),
      const Item(title: 'Curve Animation', widget: ScaleAnimationDemo()),
      const Item(title: 'Animated Button', widget: AnimatedButtonWidget()),
      const Item(title: 'Hero Animation', widget: HeroAnimation()),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation '),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return ListTile(
            title: Text(item.title),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text(item.title),
                      ),
                      body: item.widget,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
