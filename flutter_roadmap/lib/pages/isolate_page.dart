import 'dart:collection';
import 'dart:isolate';

import 'package:flutter/material.dart';

class IsolatePage extends StatefulWidget {
  const IsolatePage({super.key});

  @override
  State<IsolatePage> createState() => _IsolatePageState();
}

class _IsolatePageState extends State<IsolatePage> {
  Future<int>? _fibonacciFuture;

  @override
  void initState() {
    super.initState();
    _fibonacciFuture = computedFibonacci(4000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Isolated demo'),
      ),
      body: FutureBuilder<int>(
        future: _fibonacciFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 当 Future 还在执行时，显示一个加载指示器
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // 如果 Future 执行过程中发生错误，显示错误信息
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            // 当 Future 成功完成时，显示计算结果
            return Text('The 40th Fibonacci number is ${snapshot.data}');
          } else {
            // 处理没有数据的意外情况
            return Text('No data available');
          }
        },
      ),
    );
  }

  // 主线程中启动一个新的 isolate 来计算斐波那契数列
  Future<int> computedFibonacci(int n) async {
    // 创建一个 ReceivePort 用于接收来自 Isolate 的消息
    final receivePort = ReceivePort();

    // 启动一个新的 isolate，并将计算函数和参数传递过去
    await Isolate.spawn(_calculateFibonacci, [n, receivePort.sendPort]);

    // 将 n 参数传递给 isolate，并等待结果返回
    final sendPort = await receivePort.first as SendPort;
    final answerPort = ReceivePort();
    sendPort.send([n, answerPort.sendPort]);

    return await answerPort.first as int;
  }

  // 在新的 isolate 中计算斐波那契数列
  static void _calculateFibonacci(List<dynamic> args) async {
    final int n = args[0] as int;
    final SendPort sendPort = args[1] as SendPort;
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    await for (final message in receivePort) {
      final SendPort replyPort = message[1] as SendPort;
      replyPort.send(_fibonacci(n));
    }
  }

  static final Map<int, int> _fibonacciCache = HashMap<int, int>();

  static int _fibonacci(int n) {
    if (n <= 2) {
      return 1;
    }
    if (_fibonacciCache.containsKey(n)) return _fibonacciCache[n]!;
    final result = _fibonacci(n - 2) + _fibonacci(n - 1);
    _fibonacciCache[n] = result;
    return result;
  }
}
