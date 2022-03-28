part of 'categories_bloc.dart';

class CategoriesState extends Equatable {
  final FormzStatus status;
  final List<CategoryResponse> categories;

  const CategoriesState({
    required this.status,
    required this.categories,
  });

  CategoriesState copyWith({
    FormzStatus? status,
    List<CategoryResponse>? categories,
  }) =>
      CategoriesState(
        status: status ?? this.status,
        categories: categories ?? this.categories,
      );
      
  @override
  List<Object> get props => [status, categories];
}
