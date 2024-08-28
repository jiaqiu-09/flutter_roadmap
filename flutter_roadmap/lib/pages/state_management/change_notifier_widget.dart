import 'dart:math';

import 'package:flutter/material.dart';

class ChangeNotifierWidget extends StatelessWidget {
  const ChangeNotifierWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final counterModel = CounterModel();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('current values:'),
        TextButton(
            onPressed: () {
              counterModel.add();
            },
            child: const Text('add value')),
        Expanded(
          child: CounterWidget(
            listenable: counterModel,
          ),
        ),
      ],
    );
  }
}

class CounterModel with ChangeNotifier {
  final List<int> _values = [];
  get values => _values.toList();

  void add() {
    _values.add(Random().nextInt(1000000000));
    notifyListeners();
  }
}

class CounterWidget extends StatelessWidget {
  final CounterModel listenable;
  const CounterWidget({super.key, required this.listenable});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: listenable,
        builder: (context, Widget? child) {
          final List<int> data = listenable.values;
          return data.isEmpty
              ? const SizedBox.shrink()
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(data[index].toString()),
                    );
                  });
        });
  }
}
