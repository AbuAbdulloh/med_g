import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:med_g/models/article/article.dart';
import 'package:med_g/repository/articles_repository.dart';
import 'package:med_g/repository/save_unsave_repository.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final ArticleRepository _repository;
  final SaveUnsaveRepository _saveUnsaveRepository;
  late StreamSubscription streamSubscription;
  ArticlesBloc({
    required ArticleRepository repository,
    required SaveUnsaveRepository saveUnsaveRepository,
  })  : _repository = repository,
        _saveUnsaveRepository = saveUnsaveRepository,
        super(
          const ArticlesState(
            status: FormzStatus.pure,
            articles: [],
          ),
        ) {
    streamSubscription = _saveUnsaveRepository.articleStream.listen((id) {
      print(id);
      print('In article bloc');
      add(SaveUnsaveArticle(id));
    });
    on<GetArticles>((event, emit) async {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      try {
        final articles = await _repository.getArticles();
        emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          articles: articles,
        ));
        event.onSucces();
      } catch (e) {
        print('$e');
        emit(state.copyWith(status: FormzStatus.submissionFailure));
        event.onError('$e');
      }
    });

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
