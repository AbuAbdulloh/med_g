part of 'articles_bloc.dart';

abstract class ArticlesEvent extends Equatable {
  const ArticlesEvent();

  @override
  List<Object> get props => [];
}

class GetArticles extends ArticlesEvent {
  final Function() onSucces;
  final Function(String message) onError;
  const GetArticles({
    required this.onSucces,
    required this.onError,
  });
  @override
  List<Object> get props => [onSucces, onError];

  @override
  String toString() => 'GetArticles(onSucces: $onSucces, onError: $onError)';
}
