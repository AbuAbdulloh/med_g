part of 'category_single_bloc.dart';

abstract class CategorySingleEvent extends Equatable {
  const CategorySingleEvent();

  @override
  List<Object> get props => [];
}

class GetCategoryArticles extends CategorySingleEvent {
  final String slug;
  final Function(String message) onError;

  const GetCategoryArticles({
    required this.slug,
    required this.onError,
  });

  @override
  List<Object> get props => [slug, onError];

  @override
  String toString() => 'GetCategoryArticles(slug: $slug, onError: $onError)';
}
