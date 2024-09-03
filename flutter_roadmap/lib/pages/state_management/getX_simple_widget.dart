import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetXSimpleWidget extends StatelessWidget {
  var count = 0.obs;

  @override
  Widget build(context) {
    return Column(
      children: [
        Obx(() => Text('Current value $count')),
        TextButton(
            onPressed: () {
              count++;
            },
            child: const Text('Increment')),
        TextButton(
            onPressed: () {
              count--;
            },
            child: const Text('Decrement'))
      ],
    );
  }
}
