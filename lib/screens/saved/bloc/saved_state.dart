part of 'saved_bloc.dart';

class SavedState extends Equatable {
  final FormzStatus status;
  final FormzStatus paginationStatus;
  final List<Article> articles;

  const SavedState({
    required this.status,
    required this.paginationStatus,
    required this.articles,
  });

  SavedState copyWith({
    FormzStatus? status,
    FormzStatus? paginationStatus,
    List<Article>? articles,
  }) {
    return SavedState(
      status: status ?? this.status,
      paginationStatus: paginationStatus ?? this.paginationStatus,
      articles: articles ?? this.articles,
    );
  }

  @override
  List<Object> get props => [status, paginationStatus, articles];
}
