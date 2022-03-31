import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:med_g/models/article/article.dart';
import 'package:med_g/models/category/category.dart';
import 'package:med_g/repository/category_repository.dart';
import 'package:med_g/repository/save_unsave_repository.dart';

part 'category_single_event.dart';
part 'category_single_state.dart';

class CategorySingleBloc
    extends Bloc<CategorySingleEvent, CategorySingleState> {
  final CategoryRepository _repository;
  final SaveUnsaveRepository _saveUnsaveRepository;
  late StreamSubscription streamSubscription;
  CategorySingleBloc({
    required CategoryRepository repository,
    required SaveUnsaveRepository saveUnsaveRepository,
  })  : _repository = repository,
        _saveUnsaveRepository = saveUnsaveRepository,
        super(
          CategorySingleState(
            status: FormzStatus.pure,
            category: CategoryResponse.fromJson(const {}),
            articles: const [],
          ),
        ) {
    streamSubscription = _saveUnsaveRepository.articleStream.listen((id) {
      print(id);
      print('In Category Single bloc');

      add(SaveUnsaveArticle(id));
    });
    on<GetCategoryArticles>((event, emit) async {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final categorySingle =
            await _repository.getCategoryArticles(slug: event.slug);
        emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          articles: categorySingle.articles,
          category: categorySingle.category,
        ));
      } catch (e) {
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
