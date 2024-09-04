import 'dart:async';

import 'package:flutter/material.dart';

abstract class BlocBase {
  void dispose();
}

class MyBloc extends BlocBase {
  int _counter = 0;
  final _counterController = StreamController<int>.broadcast();

  Stream<int> get counterStream => _counterController.stream;

  int get counter => _counter;

  void increment() {
    _counter++;
    _counterController.add(_counter);
  }

  void decrement() {
    _counter--;
    _counterController.add(_counter);
  }

  @override
  void dispose() {
    _counterController.close();
  }
}

class CustomBlocProvider<T extends BlocBase> extends StatefulWidget {
  final T bloc;
  final Widget child;
  const CustomBlocProvider({
    super.key,
    required this.child,
    required this.bloc,
  });

  @override
  State<CustomBlocProvider<BlocBase>> createState() {
    return _CustomBlocProvider<T>();
  }

  static T of<T extends BlocBase>(BuildContext context) {
    // final type = _typeOf<CustomBlocProvider<T>>();
    final provider = context.findAncestorWidgetOfExactType<CustomBlocProvider<T>>();
    assert(provider != null, 'No BlocProvider found in context');
    return provider!.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _CustomBlocProvider<T> extends State<CustomBlocProvider<BlocBase>> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
