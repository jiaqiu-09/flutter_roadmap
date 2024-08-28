import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_roadmap/pages/state_management/redux/actions.dart';
import 'package:flutter_roadmap/pages/state_management/redux/reducer.dart';
import 'package:flutter_roadmap/pages/state_management/redux/state.dart';
import 'package:redux/redux.dart';

class ReduxWidget extends StatelessWidget {
  const ReduxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Store<CounterState> store = Store(counterReducer, initialState: CounterState(100));
    return StoreProvider(
      store: store,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StoreConnector<CounterState, int>(
              builder: (context, counter) {
                return Text(
                  'Current value $counter',
                );
              },
              converter: (store) => store.state.counter),
          TextButton(
              onPressed: () {
                store.dispatch(IncrementAction());
              },
              child: const Text('increment')),
          TextButton(
              onPressed: () {
                store.dispatch(DecrementAction());
              },
              child: const Text('decrement')),
        ],
      ),
    );
  }
}
