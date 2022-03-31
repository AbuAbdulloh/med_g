part of 'save_bloc.dart';

class SaveState extends Equatable {
  final FormzStatus status;
  final bool isSaved;
  const SaveState({
    required this.status,
    required this.isSaved,
  });

  SaveState copyWith({
    FormzStatus? status,
    bool? isSaved,
  }) {
    return SaveState(
      status: status ?? this.status,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  List<Object> get props => [status, isSaved];
}
