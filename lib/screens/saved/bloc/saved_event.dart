part of 'saved_bloc.dart';

abstract class SavedEvent extends Equatable {
  const SavedEvent();

  @override
  List<Object> get props => [];
}

class GetSavedArticles extends SavedEvent {
  final Function(String message) onError;

  const GetSavedArticles(this.onError);
}

class GetMoreSavedArticles extends SavedEvent {
  final Function(String message) onError;

  const GetMoreSavedArticles(this.onError);
}
