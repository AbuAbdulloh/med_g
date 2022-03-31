import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:med_g/models/article/article.dart';
import 'package:med_g/repository/save_unsave_repository.dart';

part 'save_event.dart';
part 'save_state.dart';

class SaveBloc extends Bloc<SaveEvent, SaveState> {
  final SaveUnsaveRepository repository;

  SaveBloc({required this.repository})
      : super(const SaveState(
          status: FormzStatus.pure,
          isSaved: false,
        )) {
    on<GetSavedStatus>((event, emit) {
      emit(state.copyWith(
        status: FormzStatus.pure,
        isSaved: event.isSaved,
      ));
    });
    on<ChangeSavedStatus>((event, emit) async {
      final article = event.article.copyWith(
        saved: !event.article.saved,
      );
      emit(SaveState(
        isSaved: article.saved,
        status: FormzStatus.submissionInProgress,
      ));
      if (event.article.saved) {
        try {
          await repository.unsavearticle(
            event.article.id,
          );
          emit(SaveState(
            isSaved: article.saved,
            status: FormzStatus.submissionSuccess,
          ));
        } on Exception catch (e) {
          emit(SaveState(
            status: FormzStatus.submissionFailure,
            isSaved: !article.saved,
          ));
          event.onError('$e');
        }
      } else {
        try {
          await repository.saveArticle(event.article.id);
          emit(SaveState(
            status: FormzStatus.submissionSuccess,
            isSaved: article.saved,
          ));
        } on Exception catch (e) {
          emit(SaveState(
            status: FormzStatus.submissionFailure,
            isSaved: !article.saved,
          ));
          event.onError('$e');
        }
      }
    });
  }

  
}
