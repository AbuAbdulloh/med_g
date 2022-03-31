import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/repository/articles_repository.dart';
import 'package:med_g/repository/category_repository.dart';
import 'package:med_g/repository/save_unsave_repository.dart';
import 'package:med_g/screens/category_single/category_single_screen.dart';
import 'package:med_g/screens/home/home.dart';
import 'package:med_g/screens/main/bloc/articles/articles_bloc.dart';
import 'package:med_g/screens/main/bloc/categories/categories_bloc.dart';
import 'package:med_g/screens/main/widgets/article_item.dart';
import 'package:med_g/screens/main/widgets/category_item.dart';
import 'package:med_g/screens/main/widgets/main_app_bar.dart';
import 'package:med_g/widgets/w_error_snack_bar.dart';
import 'package:med_g/widgets/w_scale_animation.dart';
import 'package:shimmer/shimmer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late TextEditingController searchController;
  late ArticlesBloc articlesBloc;
  late CategoriesBloc categoriesBloc;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    articlesBloc = ArticlesBloc(
      repository: RepositoryProvider.of<ArticleRepository>(context),
      saveUnsaveRepository:
          RepositoryProvider.of<SaveUnsaveRepository>(context),
    );
    categoriesBloc = CategoriesBloc(
      repository: RepositoryProvider.of<CategoryRepository>(context),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
    articlesBloc.close();
    categoriesBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: articlesBloc,
          ),
          BlocProvider.value(
            value: categoriesBloc,
          ),
        ],
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (_, __) => [
              MainAppBar(searchController: searchController),
            ],
            body: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'Turkumlar',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                SizedBox(
                  height: 186,
                  child: BlocBuilder<CategoriesBloc, CategoriesState>(
                    builder: (context, state) {
                      if (state.status == FormzStatus.pure) {
                        categoriesBloc.add(GetCategories(
                          onSucces: () {},
                          onError: (message) {
                            showErrorSnackBar(context, message);
                          },
                        ));
                        return const SizedBox.shrink();
                      } else if (state.status ==
                          FormzStatus.submissionInProgress) {
                        return ListView.separated(
                          clipBehavior: Clip.none,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(
                              left: 16, top: 12, bottom: 8, right: 16),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) => Shimmer.fromColors(
                            child: Container(
                              width: 160,
                              height: 150,
                              color: white,
                            ),
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                          ),
                          separatorBuilder: (_, __) => const SizedBox(width: 4),
                          itemCount: 5,
                        );
                      } else if (state.status ==
                          FormzStatus.submissionSuccess) {
                        return ListView.separated(
                          clipBehavior: Clip.none,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(
                              left: 16, top: 12, bottom: 8, right: 16),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) => CategoryItem(
                            category: state.categories[index],
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => CategorySingleScreen(
                                    category: state.categories[index],
                                  ),
                                ),
                              );
                            },
                          ),
                          separatorBuilder: (_, __) => const SizedBox(width: 4),
                          itemCount: state.categories.length,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    Text(
                      'So’nggi maqolalar',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const Spacer(),
                    WScaleAnimation(
                      onTap: () {
                        HomeTabControllerProvider.of(context)
                            .controller
                            .animateTo(1);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Barcha maqolalar',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
                BlocBuilder<ArticlesBloc, ArticlesState>(
                  builder: (context, state) {
                    if (state.status == FormzStatus.pure) {
                      articlesBloc.add(GetArticles(
                        onSucces: () {},
                        onError: (message) {
                          showErrorSnackBar(context, message);
                        },
                      ));
                      return const SizedBox.shrink();
                    } else if (state.status ==
                        FormzStatus.submissionInProgress) {
                      return const Center(child: CupertinoActivityIndicator());
                    } else if (state.status == FormzStatus.submissionSuccess) {
                      return ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        physics: const ClampingScrollPhysics(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
