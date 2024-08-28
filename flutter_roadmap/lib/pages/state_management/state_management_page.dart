import 'package:flutter/material.dart';
import 'package:flutter_roadmap/pages/state_management/change_notifier_widget.dart';
import 'package:flutter_roadmap/pages/state_management/redux/redux_widget.dart';
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
      const Item(
        title: 'Redux',
        widget: ReduxWidget(),
      )
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
