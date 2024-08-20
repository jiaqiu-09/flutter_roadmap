import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_roadmap/pages/sqflite/sqflite_utils.dart';
import 'package:sqflite/sqflite.dart';

class SQflitePage extends StatefulWidget {
  const SQflitePage({super.key});

  @override
  State<SQflitePage> createState() => _SQflitePageState();
}

class DataItem {
  final int id;
  final String name;
  final String value;
  const DataItem({required this.id, required this.name, required this.value});

  factory DataItem.fromJson(Map<String, dynamic> map) {
    return DataItem(
      id: map['id'],
      name: map['name'].toString(),
      value: map['value'].toString(),
    );
  }
}

class _SQflitePageState extends State<SQflitePage> {
  Database? db;
  List<DataItem> items = [];
  final _formKey = GlobalKey<FormState>();
  late Completer<void> _completer;

  @override
  void initState() {
    super.initState();
    _completer = Completer<void>();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    if (db != null) {
      db!.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQflite'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showFormDialog(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<void>(
        future: _completer.future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 异步操作尚未完成，显示加载指示器
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // 异步操作出错，显示错误信息
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    leading: CircleAvatar(child: Text(item.id.toString())),
                    title: Text(item.name),
                    subtitle: Text('Value: ${item.value}'),
                  );
                });
          } else {
            // 处理意外情况
            return Text('Unexpected State');
          }
        },
      ),
    );
  }

  Future<void> loadData() async {
    db ??= await openDB();
    final list = await getItems(db!);
    _completer.complete();
    setState(() {
      items = list.map((e) => DataItem.fromJson(e)).toList();
    });
  }

  Future<void> updateList() async {
    final list = await getItems(db!);
    setState(() {
      items = list.map((e) => DataItem.fromJson(e)).toList();
    });
  }

  void showFormDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController valueController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Fill the Form'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  controller: valueController,
                  decoration: const InputDecoration(
                    labelText: 'Value',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () async {
                // Here you can process the form data
                print('Field 2: ${nameController.text}');
                print('Field 3: ${valueController.text}');
                if (_formKey.currentState?.validate() == true) {
                  db ??= await openDB();
                  await insertItem(db!, {
                    'id': Random().nextInt(1000000),
                    'name': nameController.text,
                    'value': valueController.text,
                  });
                  updateList();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
