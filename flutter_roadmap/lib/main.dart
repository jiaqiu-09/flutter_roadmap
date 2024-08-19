import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_roadmap/pages/home_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scripts/encrypt.dart';

import 'blocs/app_env/app_env_cubit.dart';

void main() async {
  await initHiveForFlutter();

  runApp(MyApp());
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
            return Scaffold(
              body: Center(
                child: Text('Config load error'),
              ),
            );
          }
          if (state is AppEnvLoadSuccess) {
            final HttpLink httpLink = HttpLink(
              EncryptUtil.decryptString(state.config['GIT_URL']!, state.config['SECRET_KEY']!),
            );

            final String token = EncryptUtil.decryptString(state.config['GIT_TOKEN']!, state.config['SECRET_KEY']!);
            final AuthLink authLink = AuthLink(
              headerKey: 'Authorization',
              getToken: () async => 'Bearer $token',
            );

            final Link link = authLink.concat(httpLink);

            final GraphQLClient client = GraphQLClient(
              link: link,
              cache: GraphQLCache(store: HiveStore()),
            );
            return GraphQLProvider(
              client: ValueNotifier(client),
              child: MaterialApp(
                title: 'Flutter Roadmap',
                theme: ThemeData(
                  // This is the theme of your application.
                  //
                  // TRY THIS: Try running your application with "flutter run". You'll see
                  // the application has a purple toolbar. Then, without quitting the app,
                  // try changing the seedColor in the colorScheme below to Colors.green
                  // and then invoke "hot reload" (save your changes or press the "hot
                  // reload" button in a Flutter-supported IDE, or press "r" if you used
                  // the command line to start the app).
                  //
                  // Notice that the counter didn't reset back to zero; the application
                  // state is not lost during the reload. To reset the state, use hot
                  // restart instead.
                  //
                  // This works for code too, not just values: Most code changes can be
                  // tested with just a hot reload.
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                home: const HomePage(),
              ),
            );
          }
          return MaterialApp(home: SizedBox.shrink());
        },
      ),
    );
  }
}
