import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(storeKey);
    if (data != null) {
      setState(() {
        savedString = data;
      });
    }
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
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString(storeKey, 'updated');
                setState(() {
                  savedString = 'updated';
                });
              },
              child: Text('update')),
          TextButton(
              onPressed: () async {
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove(storeKey);
                setState(() {
                  savedString = '';
                });
              },
              child: Text('delete')),
        ],
      ),
    );
  }
}
