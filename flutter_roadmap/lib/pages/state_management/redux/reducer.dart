import './actions.dart';
import './state.dart';

CounterState counterReducer(CounterState state, dynamic action) {
  if (action is IncrementAction) {
    return CounterState(state.counter + 1);
  } else if (action is DecrementAction) {
    return CounterState(state.counter - 1);
  }

  return state;
}
