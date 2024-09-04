import 'package:flutter/material.dart';
import 'package:flutter_roadmap/pages/state_management/custom_bloc/custom_bloc.dart';

class CustomBlocWidget extends StatelessWidget {
  const CustomBlocWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBlocProvider<MyBloc>(
      bloc: MyBloc(),
      child: const TestPage(),
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = CustomBlocProvider.of<MyBloc>(context);

    return StreamBuilder(
        stream: bloc.counterStream,
        builder: (context, snapshot) {
          final counter = snapshot.data ?? 0;

          return Column(
            children: [
              Text('Current value $counter'),
              TextButton(
                  onPressed: () {
                    bloc.increment();
                  },
                  child: const Text('Increment')),
              TextButton(
                  onPressed: () {
                    bloc.decrement();
                  },
                  child: const Text('Decrement'))
            ],
          );
        });
  }
}
