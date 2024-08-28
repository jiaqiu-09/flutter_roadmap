import 'package:flutter/material.dart';

class Counter {
  late final ValueNotifier<int> count;
  final int initialValue;
  Counter({required this.initialValue}) : count = ValueNotifier(initialValue);

  void incrementCount() {
    count.value++;
  }

  void decrementCount() {
    count.value--;
  }
}

class ValueNotifierWidget extends StatelessWidget {
  const ValueNotifierWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Counter counter = Counter(initialValue: 200);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder(
            valueListenable: counter.count,
            builder: (context, count, Widget? child) {
              return Text('current values: $count');
            }),
        TextButton(
            onPressed: () {
              counter.incrementCount();
            },
            child: const Text('increment')),
        TextButton(
            onPressed: () {
              counter.decrementCount();
            },
            child: const Text('decrement')),
      ],
    );
  }
}
