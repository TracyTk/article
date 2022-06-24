import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:article_finder/data/article.dart';
import 'package:article_finder/data/rw_client.dart';

import 'bloc.dart';

class ArticleListBloc implements Bloc {
  // 1
  final _client = RWClient();
  // 2
  final _searchQueryController = StreamController<String?>();
  // 3
  Sink<String?> get searchQuery => _searchQueryController.sink;
  // 4
  late Stream<List<Article>?> actriclesStream;

  ArticleListBloc() {
    // 5
    actriclesStream = _searchQueryController.stream
        .startWith(null) // 1
        .debounceTime(const Duration(milliseconds: 100)) // 2
        .switchMap((query) => _client
                .fetchArticles(query)
                .asStream() // 4
                .startWith(null) // 5
            );
  }
  // 6
  @override
  void dispose() {
    _searchQueryController.close();
  }
}
