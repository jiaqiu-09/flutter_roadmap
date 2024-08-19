import 'package:flutter/material.dart';
import 'package:flutter_roadmap/pages/graphql_page.dart';
import 'package:flutter_roadmap/pages/websocket_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  child: Text('WebSocket'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return const WebsocketPage();
                    }));
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  child: Text('GraphQL'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return const GraphQLPage();
                    }));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
