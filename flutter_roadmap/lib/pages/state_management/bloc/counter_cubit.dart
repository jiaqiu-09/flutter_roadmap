import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit({int initialValue = 0}) : super(CounterInitial(count: initialValue));

  void increment() {
    emit(CounterUpdated(count: state.value + 1));
  }

  void decrement() {
    emit(CounterUpdated(count: state.value - 1));
  }
}
