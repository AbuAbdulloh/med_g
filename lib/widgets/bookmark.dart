import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/bloc/auth/authentication_bloc.dart';
import 'package:med_g/bloc/save/save_bloc.dart';
import 'package:med_g/models/article/article.dart';
import 'package:med_g/models/authentication_status/authentication_status.dart';
import 'package:med_g/repository/save_unsave_repository.dart';
import 'package:med_g/widgets/w_error_snack_bar.dart';
import 'package:med_g/widgets/w_scale_animation.dart';

class BookMark extends StatelessWidget {
  final Article article;
  const BookMark({
    required this.article,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => SaveBloc(
            repository: RepositoryProvider.of<SaveUnsaveRepository>(context))
          ..add(GetSavedStatus(isSaved: article.saved)),
        child: BlocBuilder<SaveBloc, SaveState>(
          builder: (context, state) {
            if (state.status == FormzStatus.submissionInProgress) {
              return WScaleAnimation(
                isDisabled: context.read<AuthenticationBloc>().state.status !=
                    AuthenticationStatus.authenticated,
                onTap: () {},
                child: context.read<AuthenticationBloc>().state.status ==
                        AuthenticationStatus.authenticated
                    ? AnimatedSwitcher(
                        duration: const Duration(milliseconds: 0),
                        child: state.isSaved
                            ? SvgPicture.asset(
                                AppIcons.bookmarkFilled,
                                width: 28,
                                height: 28,
                                color: dark,
                                key: const ValueKey('bookmarkFilled'),
                              )
                            : SvgPicture.asset(
                                AppIcons.bookmarkOutlined,
                                width: 28,
                                height: 28,
                                key: const ValueKey('bookmarkUnfilled'),
                              ),
                        transitionBuilder: (child, animation) =>
                            ScaleTransition(scale: animation, child: child),
                      )
                    : const SizedBox(),
              );
            } else {
              return WScaleAnimation(
                isDisabled: context.read<AuthenticationBloc>().state.status !=
                    AuthenticationStatus.authenticated,
                onTap: () {
                  context.read<SaveBloc>().add(ChangeSavedStatus(
                      article: article,
                      onSucces: () {},
                      onError: (message) {
                        showErrorSnackBar(context, message);
                      }));
                },
                child: context.read<AuthenticationBloc>().state.status ==
                        AuthenticationStatus.authenticated
                    ? AnimatedSwitcher(
                        duration: const Duration(milliseconds: 0),
                        child: article.saved
                            ? SvgPicture.asset(
                                AppIcons.bookmarkFilled,
                                width: 28,
                                height: 28,
                                color: dark,
                                key: const ValueKey('bookmarkFilled'),
                              )
                            : SvgPicture.asset(
                                AppIcons.bookmarkOutlined,
                                width: 28,
                                height: 28,
                                key: const ValueKey('bookmarkUnfilled'),
                              ),
                        transitionBuilder: (child, animation) =>
                            ScaleTransition(scale: animation, child: child),
                      )
                    : const SizedBox(),
              );
            }
          },
        ),
      );
}
