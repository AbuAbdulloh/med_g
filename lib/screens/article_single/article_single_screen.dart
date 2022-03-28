import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:jiffy/jiffy.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/app_images.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/models/article/article.dart';
import 'package:med_g/repository/articles_repository.dart';
import 'package:med_g/screens/article_single/bloc/bloc.dart';
import 'package:med_g/widgets/cached_image.dart';
import 'package:med_g/widgets/w_error_snack_bar.dart';
import 'package:med_g/widgets/w_scale_animation.dart';

class ArticleSingleScreen extends StatefulWidget {
  final Article article;
  const ArticleSingleScreen({
    required this.article,
    Key? key,
  }) : super(key: key);

  @override
  State<ArticleSingleScreen> createState() => _ArticleSingleScreenState();
}

class _ArticleSingleScreenState extends State<ArticleSingleScreen> {
  late BlocBloc bloc;

  @override
  void initState() {
    bloc = BlocBloc(
      repository: RepositoryProvider.of<ArticleRepository>(context),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        body: BlocBuilder<BlocBloc, BlocState>(
          builder: (context, state) {
            if (state.status == FormzStatus.pure) {
              bloc.add(GetSingleArticle(
                slug: widget.article.id,
                onError: (message) {
                  showErrorSnackBar(context, message);
                },
              ));
              return const SizedBox.shrink();
            } else if (state.status == FormzStatus.submissionInProgress) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state.status == FormzStatus.submissionSuccess) {
              return NestedScrollView(
                headerSliverBuilder: (_, isExpanded) => [
                  SliverAppBar(
                    elevation: 2,
                    shadowColor: black.withOpacity(0.25),
                    pinned: true,
                    toolbarHeight: 56,
                    backgroundColor: white,
                    titleSpacing: 0,
                    expandedHeight: MediaQuery.of(context).padding.top + 238,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: false,
                      expandedTitleScale: 1,
                      titlePadding: EdgeInsets.zero,
                      title: Padding(
                        padding: const EdgeInsets.only(left: 50, bottom: 16),
                        child: Text(
                          widget.article.title,
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      background: CachedImage(
                        fit: BoxFit.cover,
                        url: widget.article.thumbnail,
                        height: double.maxFinite,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    leading: WScaleAnimation(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: SvgPicture.asset(AppIcons.arrowLeft),
                      ),
                    ),
                  )
                ],
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(12),
                          right: Radius.circular(12),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.article.title,
                            style:
                                Theme.of(context).textTheme.headline1!.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              '${state.article.category?.name} / ${Jiffy(state.article.createdAt).format('dd.MM.yyyy')}y',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          Text(
                            state.article.content,
                            style:
                                Theme.of(context).textTheme.headline1!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
