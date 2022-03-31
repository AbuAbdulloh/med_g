import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:med_g/models/article/article.dart';
import 'package:med_g/repository/articles_repository.dart';

part 'saved_event.dart';
part 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  final ArticleRepository _articleRepository;
  SavedBloc({required ArticleRepository repository})
      : _articleRepository = repository,
        super(
          const SavedState(
            status: FormzStatus.pure,
            paginationStatus: FormzStatus.pure,
            articles: [],
          ),
        ) {
    on<GetSavedArticles>((event, emit) async {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final savedArticles = await _articleRepository.getSavedArticles();
        emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          articles: savedArticles,
        ));
      } catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
        event.onError('$e');
      }
    });

    on<GetMoreSavedArticles>((event, emit) {});
  }
}
