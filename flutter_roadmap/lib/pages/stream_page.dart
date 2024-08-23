import 'dart:async';

import 'package:flutter/material.dart';

class StreamPage extends StatelessWidget {
  const StreamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Page'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('StreamBuilder'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return StreamBuilderPage();
              }));
            },
          ),
          ListTile(
            title: Text('StreamSubscription'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return StreamSubscriptionPage();
              }));
            },
          ),
          ListTile(
            title: Text('StreamController'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return StreamControllerPage();
              }));
            },
          )
        ],
      ),
    );
  }
}

class StreamControllerPage extends StatefulWidget {
  const StreamControllerPage({super.key});

  @override
  State<StreamControllerPage> createState() => _StreamControllerPageState();
}

class _StreamControllerPageState extends State<StreamControllerPage> {
  StreamSubscription<int>? subscription;
  final Stream<int> stream = timedCounterWithController(Duration(seconds: 2), 10);
  String textValue = '';

  @override
  void initState() {
    super.initState();
    subscription = stream.listen((event) {
      setState(() {
        textValue = event.toString();
      });
    }, onDone: () {
      print('Stream done');
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StreamSubscription'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                subscription?.pause();
              },
              child: Text('pause'),
            ),
            Text(
              'Count: $textValue',
              style: const TextStyle(fontSize: 24),
            ),
            TextButton(
              onPressed: () {
                subscription?.resume();
              },
              child: Text('resume'),
            ),
          ],
        ),
      ),
    );
  }
}

class StreamSubscriptionPage extends StatefulWidget {
  const StreamSubscriptionPage({super.key});

  @override
  State<StreamSubscriptionPage> createState() => _StreamSubscriptionPageState();
}

class _StreamSubscriptionPageState extends State<StreamSubscriptionPage> {
  StreamSubscription<int>? subscription;
  String textValue = '';

  @override
  void initState() {
    super.initState();
    subscription = timedCounter(const Duration(seconds: 2), 10).listen((event) {
      setState(() {
        textValue = event.toString();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StreamSubscription'),
      ),
      body: Center(
        child: Text(
          'Count: $textValue',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class StreamBuilderPage extends StatelessWidget {
  const StreamBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Builder'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: timedCounter(const Duration(seconds: 2), 10),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.hasError}');
            } else if (!snapshot.hasData) {
              return const Text('No data available');
            } else {
              return Text(
                'Count: ${snapshot.data}',
                style: const TextStyle(fontSize: 24),
              );
            }
          },
        ),
      ),
    );
  }
}

// create a stream from scratch
Stream<int> timedCounter(Duration interval, [int? maxCount]) async* {
  int i = 0;
  while (true) {
    await Future.delayed(interval);
    yield i++;
    if (i == maxCount) break;
  }
}

// create a stream from scratch
Stream<int> timedCounterWithController(Duration interval, [int? maxCount]) {
  late StreamController<int> controller;
  Timer? timer;
  int counter = 0;
  void tick(Timer timer) {
    counter++;
    controller.add(counter);
    if (maxCount != null && counter >= maxCount) {
      timer.cancel();
      controller.close();
    }
  }

  controller = StreamController(
    onListen: () {
      timer = Timer.periodic(interval, tick);
    },
    onPause: () {
      timer?.cancel();
    },
    onResume: () {
      timer = Timer.periodic(interval, tick);
    },
    onCancel: () {
      timer?.cancel();
      controller.close();
    },
  );

  return controller.stream;
}
