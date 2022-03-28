part of 'category_single_bloc.dart';

class CategorySingleState extends Equatable {
  final FormzStatus status;
  final List<Article> articles;
  final CategoryResponse category;

  const CategorySingleState({
    required this.status,
    required this.articles,
    required this.category,
  });

  CategorySingleState copyWith({
    FormzStatus? status,
    List<Article>? articles,
    CategoryResponse? category,
  }) =>
      CategorySingleState(
        status: status ?? this.status,
        articles: articles ?? this.articles,
        category: category ?? this.category,
      );
      
  @override
  List<Object> get props => [status, articles, category];
}
