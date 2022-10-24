import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Api {

  ValueNotifier<GraphQLClient> client() {
    return ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: HttpLink(
          'http://130.61.8.73:8080/graphql',
        ),
        cache: GraphQLCache(
          store: HiveStore(),
        ),
      ),
    );
  }

}
