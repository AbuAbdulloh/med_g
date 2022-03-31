part of 'save_bloc.dart';

abstract class SaveEvent extends Equatable {
  const SaveEvent();

  @override
  List<Object> get props => [];
}

class GetSavedStatus extends SaveEvent {
  final bool isSaved;

  const GetSavedStatus({
    required this.isSaved,
  });
}

class ChangeSavedStatus extends SaveEvent {
  final Article article;
  final Function() onSucces;
  final Function(String message) onError;
  const ChangeSavedStatus({
    required this.article,
    required this.onSucces,
    required this.onError,
  });
}
