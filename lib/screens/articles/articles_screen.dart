import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:med_g/repository/articles_repository.dart';
import 'package:med_g/repository/save_unsave_repository.dart';
import 'package:med_g/screens/main/bloc/articles/articles_bloc.dart';
import 'package:med_g/screens/main/widgets/article_item.dart';
import 'package:med_g/screens/main/widgets/main_app_bar.dart';
import 'package:med_g/widgets/w_error_snack_bar.dart';

class ArtclesScreen extends StatefulWidget {
  const ArtclesScreen({Key? key}) : super(key: key);

  @override
  State<ArtclesScreen> createState() => _ArtclesScreenState();
}

class _ArtclesScreenState extends State<ArtclesScreen> {
  late TextEditingController searchController;
  late ArticlesBloc articlesBloc;
  @override
  void initState() {
    searchController = TextEditingController();
    articlesBloc = ArticlesBloc(
      repository: RepositoryProvider.of<ArticleRepository>(context),
      saveUnsaveRepository: RepositoryProvider.of<SaveUnsaveRepository>(context),
    );
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
    articlesBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: articlesBloc,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (_, __) => [
            MainAppBar(searchController: searchController),
          ],
          body: BlocBuilder<ArticlesBloc, ArticlesState>(
            builder: (context, state) {
              if (state.status == FormzStatus.pure) {
                articlesBloc.add(GetArticles(
                  onSucces: () {},
                  onError: (message) {
                    showErrorSnackBar(context, message);
                  },
                ));
                return const SizedBox.shrink();
              } else if (state.status == FormzStatus.submissionInProgress) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.status == FormzStatus.submissionSuccess) {
                return ListView.separated(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
        ),
      ),
    );
  }
}
