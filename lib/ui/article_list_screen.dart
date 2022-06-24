import 'package:article_finder/bloc/article_list_bloc.dart';
import 'package:article_finder/bloc/bloc_provider.dart';
import 'package:article_finder/ui/article_list_item.dart';
import 'package:flutter/material.dart';

import '../data/article.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1
    final bloc = BlocProvider.of<ArticleListBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Articles')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search...',
              ),
              onChanged: bloc.searchQuery.add,
            ),
          ),
          Expanded(
            child: _buildResults(bloc),
          ),
        ],
      ),
    );
  }
}

Widget _buildResults(ArticleListBloc bloc) {
  return StreamBuilder<List<Article>?>(
    stream: bloc.actriclesStream,
    builder: (context, snapshot) {
      final results = snapshot.data;
      if (results == null) {
        return const Center(child: Text('Loading...'));
      } else if (results.isEmpty) {
        return const Center(child: Text('No Results'));
      }
      return _buildSearchResults(results);
    },
  );
}

Widget _buildSearchResults(List<Article> results) {
  return ListView.builder(
    itemCount: results.length,
    itemBuilder: (context, index) {
      final article = results[index];
      return InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ArticleListItem(article: article),
        ),
        onTap: () {
          // todo: later will be implemented
        },
      );
    },
  );
}
