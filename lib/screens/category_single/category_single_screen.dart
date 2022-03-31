import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:med_g/models/category/category.dart';
import 'package:med_g/repository/category_repository.dart';
import 'package:med_g/repository/save_unsave_repository.dart';
import 'package:med_g/screens/category_single/bloc/category_single_bloc.dart';
import 'package:med_g/screens/category_single/widgets/category_app_bar.dart';
import 'package:med_g/screens/main/widgets/article_item.dart';
import 'package:med_g/widgets/w_error_snack_bar.dart';

class CategorySingleScreen extends StatefulWidget {
  final CategoryResponse category;
  const CategorySingleScreen({
    required this.category,
    Key? key,
  }) : super(key: key);

  @override
  State<CategorySingleScreen> createState() => _CategorySingleScreenState();
}

class _CategorySingleScreenState extends State<CategorySingleScreen> {
  late TextEditingController searchController;
  late CategorySingleBloc categorySingleBloc;

  @override
  void initState() {
    searchController = TextEditingController();
    categorySingleBloc = CategorySingleBloc(
      repository: RepositoryProvider.of<CategoryRepository>(context),
      saveUnsaveRepository: RepositoryProvider.of<SaveUnsaveRepository>(context),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    categorySingleBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: categorySingleBloc,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (_, __) => [
            CategoryAppBar(
              searchController: searchController,
              title: widget.category.name,
            ),
          ],
          body: BlocBuilder<CategorySingleBloc, CategorySingleState>(
            builder: (context, state) {
              if (state.status == FormzStatus.pure) {
                categorySingleBloc.add(GetCategoryArticles(
                  slug: widget.category.slug,
                  onError: (message) {
                    showErrorSnackBar(context, message);
                  },
                ));
                return const SizedBox.shrink();
              } else if (state.status == FormzStatus.submissionInProgress) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.status == FormzStatus.submissionSuccess) {
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (_, index) => ArticleItem(
                    article: state.articles[index],
                  ),
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemCount: state.articles.length,
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
