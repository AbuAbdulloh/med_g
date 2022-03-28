part of 'articles_bloc.dart';

class ArticlesState extends Equatable {
  final FormzStatus status;
  final List<Article> articles;
  const ArticlesState({
    required this.status,
    required this.articles,
  });

  ArticlesState copyWith({
    FormzStatus? status,
    List<Article>? articles,
  }) =>
      ArticlesState(
        status: status ?? this.status,
        articles: articles ?? this.articles,
      );
  @override
  List<Object> get props => [status, articles];
}
