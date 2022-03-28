part of 'bloc.dart';

class BlocState extends Equatable {
  final FormzStatus status;
  final ArticleSingle article;

  const BlocState({
    required this.status,
    required this.article,
  });
  BlocState copyWith({
    FormzStatus? status,
    ArticleSingle? article,
  }) {
    return BlocState(
      status: status ?? this.status,
      article: article ?? this.article,
    );
  }

  @override
  List<Object> get props => [status, article];
}
