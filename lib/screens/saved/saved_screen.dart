import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:med_g/repository/articles_repository.dart';
import 'package:med_g/screens/main/widgets/article_item.dart';
import 'package:med_g/screens/saved/bloc/saved_bloc.dart';
import 'package:med_g/screens/saved/widgets/saved_appbar.dart';
import 'package:med_g/widgets/w_error_snack_bar.dart';

class SavedScreen extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const SavedScreen());
  const SavedScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  late TextEditingController searchController;
  late SavedBloc savedBloc;

  @override
  void initState() {
    searchController = TextEditingController();
    savedBloc = SavedBloc(
      repository: RepositoryProvider.of<ArticleRepository>(context),
    );
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
    savedBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: savedBloc,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (_, __) => [
            SavedAppBar(searchController: searchController),
          ],
          body: BlocBuilder<SavedBloc, SavedState>(
            builder: (context, state) {
              if (state.status == FormzStatus.pure) {
                savedBloc.add(GetSavedArticles(
                  (message) {
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
