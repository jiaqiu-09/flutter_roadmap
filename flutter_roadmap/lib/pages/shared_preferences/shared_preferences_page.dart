import 'package:flutter/material.dart';
import 'package:flutter_roadmap/pages/shared_preferences/local_storage.dart';

class SharedPreferencesPage extends StatefulWidget {
  const SharedPreferencesPage({super.key});

  @override
  State<SharedPreferencesPage> createState() => _SharedPreferencesPageState();
}

class _SharedPreferencesPageState extends State<SharedPreferencesPage> {
  String savedString = '';
  final storeKey = 'savedData';

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      savedString = LocalStorage().getString(storeKey) ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preferences'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('text from Shared Preferences: $savedString'),
          TextButton(
              onPressed: () async {
                final saved = await LocalStorage().saveString(storeKey, 'updated');
                setState(() {
                  savedString = saved == true ? 'updated' : '';
                });
              },
              child: Text('update')),
          TextButton(
              onPressed: () async {
                final removed = await LocalStorage().remove(storeKey);
                setState(() {
                  savedString = removed == true ? '' : 'remove failed';
                });
              },
              child: Text('remove')),
        ],
      ),
    );
  }
}
