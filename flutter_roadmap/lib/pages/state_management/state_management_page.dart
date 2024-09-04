import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_roadmap/pages/state_management/bloc/counter_cubit.dart';
import 'package:flutter_roadmap/pages/state_management/bloc_widget.dart';
import 'package:flutter_roadmap/pages/state_management/change_notifier_widget.dart';
import 'package:flutter_roadmap/pages/state_management/custom_bloc_widget.dart';
import 'package:flutter_roadmap/pages/state_management/getX_normal_widget.dart';
import 'package:flutter_roadmap/pages/state_management/getX_simple_widget.dart';
import 'package:flutter_roadmap/pages/state_management/provider_widget.dart';
import 'package:flutter_roadmap/pages/state_management/redux/redux_widget.dart';
import 'package:flutter_roadmap/pages/state_management/river_pod_widget.dart';
import 'package:flutter_roadmap/pages/state_management/value_notifier_widget.dart';

class Item {
  final String title;
  final Widget widget;
  const Item({required this.title, required this.widget});
}

class StateManagementPage extends StatelessWidget {
  const StateManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Item> data = [
      const Item(title: 'ChangeNotifier', widget: ChangeNotifierWidget()),
      const Item(title: 'ValueNotifier', widget: ValueNotifierWidget()),
      const Item(title: 'Redux', widget: ReduxWidget()),
      const Item(title: 'RiverPod', widget: ProviderScope(child: RiverPodWidget())),
      const Item(
        title: 'Provider',
        widget: ProviderWidget(),
      ),
      Item(
          title: 'Bloc',
          widget: BlocProvider(
            create: (context) => CounterCubit(initialValue: 100),
            child: const BlocWidget(),
          )),
      Item(title: 'GetX simple', widget: GetXSimpleWidget()),
      Item(title: 'GetX normal', widget: GetXNormalWidget()),
      const Item(title: 'Custom bloc', widget: CustomBlocWidget()),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('State management'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return ListTile(
            title: Text(item.title),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text(item.title),
                      ),
                      body: item.widget,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
