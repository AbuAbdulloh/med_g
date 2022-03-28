import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:med_g/models/article/article.dart';
import 'package:med_g/repository/articles_repository.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final ArticleRepository _repository;
  ArticlesBloc({required ArticleRepository repository})
      : _repository = repository,
        super(
          const ArticlesState(
            status: FormzStatus.pure,
            articles: [],
          ),
        ) {
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
  }
}
