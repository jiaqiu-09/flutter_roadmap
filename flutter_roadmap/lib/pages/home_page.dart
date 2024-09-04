import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> list = [
      'WebSocket',
      'GraphQL',
      'SQflite',
      'SharedPreferences',
      'Isolate',
      'Stream',
      'StateManagement',
      'Animation'
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return listItem(context, name: list[index]);
        },
      ),
    );
  }

  Widget listItem(BuildContext context, {required String name, void Function()? onTap}) {
    return ListTile(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            child: Text(name),
            onPressed: () {
              onTap?.call();
              Navigator.of(context).pushNamed('/${name.toLowerCase()}');
            },
          ),
        ],
      ),
    );
  }
}
