part of 'bloc.dart';

abstract class BlocEvent extends Equatable {
  const BlocEvent();

  @override
  List<Object> get props => [];
}

class GetSingleArticle extends BlocEvent {
  final String slug;
  final Function(String message) onError;

  const GetSingleArticle({
    required this.slug,
    required this.onError,
  });
  @override
  List<Object> get props => [slug, onError];

  @override
  String toString() => 'GetSingleArticle(slug: $slug, onError: $onError)';
}
