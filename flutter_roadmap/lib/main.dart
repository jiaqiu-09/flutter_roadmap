import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_roadmap/pages/graphql_page.dart';
import 'package:flutter_roadmap/pages/home_page.dart';
import 'package:flutter_roadmap/pages/shared_preferences/local_storage.dart';
import 'package:flutter_roadmap/pages/shared_preferences/shared_preferences_page.dart';
import 'package:flutter_roadmap/pages/sqflite/sqflite_page.dart';
import 'package:flutter_roadmap/pages/websocket_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'blocs/app_env/app_env_cubit.dart';

void main() async {
  await initHiveForFlutter();
  await LocalStorage().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppEnvCubit()..loadConfig(),
      child: BlocBuilder<AppEnvCubit, AppEnvState>(
        builder: (context, state) {
          if (state is AppEnvLoadFailure) {
            return const Scaffold(
              body: Center(
                child: Text('Config load error'),
              ),
            );
          }
          if (state is AppEnvLoadSuccess) {
            return MaterialApp(
              title: 'Flutter Roadmap',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: const HomePage(),
              routes: getRoutes(context),
            );
          }
          return const MaterialApp(home: SizedBox.shrink());
        },
      ),
    );
  }

  Map<String, WidgetBuilder> getRoutes(BuildContext context) {
    return <String, WidgetBuilder>{
      '': (BuildContext context) => const HomePage(),
      '/websocket': (BuildContext context) => const WebsocketPage(),
      '/sqflite': (BuildContext context) => const SQflitePage(),
      '/sharedpreferences': (BuildContext context) => const SharedPreferencesPage(),
      '/graphql': (BuildContext context) => BlocBuilder<AppEnvCubit, AppEnvState>(builder: (context, state) {
            if (state is AppEnvLoadSuccess) {
              return GraphQLPage(
                url: state.gitConfig.url,
                token: state.gitConfig.token,
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
    };
  }
}
