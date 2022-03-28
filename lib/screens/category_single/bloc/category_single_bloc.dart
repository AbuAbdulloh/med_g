import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:med_g/models/article/article.dart';
import 'package:med_g/models/category/category.dart';
import 'package:med_g/repository/category_repository.dart';

part 'category_single_event.dart';
part 'category_single_state.dart';

class CategorySingleBloc
    extends Bloc<CategorySingleEvent, CategorySingleState> {
  final CategoryRepository _repository;
  CategorySingleBloc({required CategoryRepository repository})
      : _repository = repository,
        super(
          CategorySingleState(
            status: FormzStatus.pure,
            category: CategoryResponse.fromJson(const {}),
            articles: const [],
          ),
        ) {
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
  }
}
