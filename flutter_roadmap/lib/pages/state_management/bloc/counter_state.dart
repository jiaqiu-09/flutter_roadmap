part of 'counter_cubit.dart';

abstract class CounterState extends Equatable {
  int get value;
  const CounterState();
}

final class CounterInitial extends CounterState {
  final int count;
  const CounterInitial({required this.count});
  @override
  List<Object> get props => [count];

  @override
  get value => count;
}

final class CounterUpdated extends CounterState {
  final int count;
  const CounterUpdated({required this.count});
  @override
  List<Object> get props => [count];

  @override
  get value => count;
}
