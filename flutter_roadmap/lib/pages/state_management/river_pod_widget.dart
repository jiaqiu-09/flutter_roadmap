import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateProvider((ref) => 100);

class RiverPodWidget extends ConsumerWidget {
  const RiverPodWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Consumer(builder: (context, ref, _) {
          final count = ref.watch(counterProvider);
          return Text('Current value: $count');
        }),
        TextButton(
            onPressed: () {
              ref.read(counterProvider.notifier).state++;
            },
            child: const Text('increment')),
        TextButton(
            onPressed: () {
              ref.read(counterProvider.notifier).state--;
            },
            child: const Text('decrement'))
      ],
    );
  }
}
