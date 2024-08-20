import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLPage extends StatelessWidget {
  final String url;
  final String token;
  const GraphQLPage({super.key, required this.url, required this.token});

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      url,
    );

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
      child: Scaffold(
        appBar: AppBar(
          title: Text('GraphQL'),
        ),
        body: Query(
            options: QueryOptions(
              document: gql(r'''
            query {
              viewer {
                login
                repositories(first: 20) {
                  nodes {
                    name
                    description
                  }
                }
              }
            }
          '''),
            ),
            builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }

              if (result.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final repositories = result.data!['viewer']['repositories']['nodes'] as List<dynamic>;

              return ListView.builder(
                  itemCount: repositories.length,
                  itemBuilder: (context, index) {
                    final repo = repositories[index];
                    return ListTile(
                      title: Text(repo['name']),
                      subtitle: Text(repo['description'] ?? 'No description'),
                    );
                  });
            }),
      ),
    );
  }
}
