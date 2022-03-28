import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:med_g/models/category/category.dart';
import 'package:med_g/repository/category_repository.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoryRepository _repository;
  CategoriesBloc({required CategoryRepository repository})
      : _repository = repository,
        super(
          const CategoriesState(status: FormzStatus.pure, categories: []),
        ) {
    on<GetCategories>((event, emit) async {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final categories = await _repository.getCategories();
        emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          categories: categories,
        ));
        event.onSucces();
      } on Exception catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
        event.onError('$e');
      }
    });
  }
}
