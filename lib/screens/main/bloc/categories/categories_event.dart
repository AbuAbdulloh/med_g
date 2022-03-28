part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class GetCategories extends CategoriesEvent {
  final Function() onSucces;
  final Function(String message) onError;
  const GetCategories({
    required this.onSucces,
    required this.onError,
  });
  @override
  List<Object> get props => [onSucces, onError];

  @override
  String toString() => 'GetCategories(onSucces: $onSucces, onError: $onError)';
}
