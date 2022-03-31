import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:med_g/models/article/article.dart';
import 'package:med_g/repository/articles_repository.dart';
import 'package:med_g/repository/save_unsave_repository.dart';

part 'saved_event.dart';
part 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  final ArticleRepository _articleRepository;
  final SaveUnsaveRepository _saveUnsaveRepository;
  late StreamSubscription streamSubscription;
  SavedBloc({
    required ArticleRepository repository,
    required SaveUnsaveRepository saveUnsaveRepository,
  })  : _articleRepository = repository,
        _saveUnsaveRepository = saveUnsaveRepository,
        super(
          const SavedState(
            status: FormzStatus.pure,
            paginationStatus: FormzStatus.pure,
            articles: [],
          ),
        ) {
    streamSubscription = _saveUnsaveRepository.articleStream.listen((id) {
      print(id);
      print('In saved bloc');
      add(SaveUnsaveArticle(id));
    });
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
    on<SaveUnsaveArticle>((event, emit) {
      final articles = <Article>[];
      for (final article in state.articles) {
        if (article.id == event.id) {
          articles.add(article.copyWith(saved: !article.saved));
        } else {
          articles.add(article);
        }
      }
      emit(state.copyWith(articles: articles));
    });
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
