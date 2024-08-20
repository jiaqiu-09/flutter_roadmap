import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_roadmap/pages/graphql_page.dart';
import 'package:flutter_roadmap/pages/sqflite/sqflite_page.dart';
import 'package:flutter_roadmap/pages/websocket_page.dart';

import '../blocs/app_env/app_env_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> list = ['WebSocket', 'GraphQL', 'SQflite'];
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
              if (name == 'WebSocket') {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const WebsocketPage();
                }));
              } else if (name == 'GraphQL') {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return BlocBuilder<AppEnvCubit, AppEnvState>(builder: (context, state) {
                    if (state is AppEnvLoadSuccess) {
                      return GraphQLPage(
                        url: state.gitConfig.url,
                        token: state.gitConfig.token,
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  });
                }));
              } else if (name == 'SQflite') {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const SQflitePage();
                }));
              }
            },
          ),
        ],
      ),
    );
  }
}
