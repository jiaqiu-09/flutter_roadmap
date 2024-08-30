import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_roadmap/pages/state_management/bloc/counter_cubit.dart';

class BlocWidget extends StatelessWidget {
  const BlocWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, CounterState>(
      builder: (context, state) {
        return Column(
          children: [
            Text('Current value: ${state.value}'),
            TextButton(
                onPressed: () {
                  final cubit = BlocProvider.of<CounterCubit>(context);
                  cubit.increment();
                },
                child: const Text('increment')),
            TextButton(
                onPressed: () {
                  final cubit = BlocProvider.of<CounterCubit>(context);
                  cubit.decrement();
                },
                child: const Text('decrement'))
          ],
        );
      },
    );
  }
}
