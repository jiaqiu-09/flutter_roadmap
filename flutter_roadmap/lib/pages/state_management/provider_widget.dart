import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderWidget extends StatelessWidget {
  const ProviderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<ProviderCounter>(
        create: (BuildContext context) => ProviderCounter(), child: const ProviderDetailWidget());
  }
}

class ProviderDetailWidget extends StatelessWidget {
  const ProviderDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<ProviderCounter>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Current value: ${counter.count}'),
        TextButton(
            onPressed: () {
              counter.increment();
              (context as Element).markNeedsBuild();
            },
            child: const Text('Increment')),
        TextButton(
            onPressed: () {
              counter.decrement();
              (context as Element).markNeedsBuild();
            },
            child: const Text('Decrement'))
      ],
    );
  }
}

class ProviderCounter {
  int _count = 100;

  int get count => _count;

  void increment() {
    _count++;
  }

  void decrement() {
    _count--;
  }
}
