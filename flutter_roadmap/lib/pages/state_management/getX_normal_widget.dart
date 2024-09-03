import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _Controller extends GetxController {
  var count = 0;
  void increment() {
    count++;
    update();
  }

  void decrement() {
    count--;
    update();
  }
}

@immutable
class GetXNormalWidget extends StatelessWidget {
  final controller = Get.put(_Controller());

  @override
  Widget build(context) {
    return Column(
      children: [
        GetBuilder<_Controller>(builder: (_) => Text('Current value ${controller.count}')),
        TextButton(
            onPressed: () {
              controller.increment();
            },
            child: const Text('Increment')),
        TextButton(
            onPressed: () {
              controller.decrement();
            },
            child: const Text('Decrement'))
      ],
    );
  }
}
