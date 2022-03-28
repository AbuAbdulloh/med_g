import 'package:flutter/material.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/data/singletons/storage.dart';
import 'package:med_g/widgets/w_button.dart';
import 'package:easy_localization/easy_localization.dart';

void showLanguageBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (_) => Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 35,
          height: 8,
          decoration: BoxDecoration(
            color: grey,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
              16, 16, 16, 16 + MediaQuery.of(context).padding.bottom),
          decoration: const BoxDecoration(
            color: white,
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(12),
              topEnd: Radius.circular(12),
            ),
          ),
          child: Column(
            children: [
              WButton(
                onTap: () {
                  StorageRepository.putString('language', 'uz');
                  context.setLocale(const Locale('uz'));
                },
                text: 'O’zbek tili',
                textStyle: Theme.of(context).textTheme.headline1!.copyWith(),
              ),
              WButton(
                onTap: () {
                  StorageRepository.putString('language', 'ru');
                  context.setLocale(const Locale('ru'));
                },
                text: 'Русский',
                textStyle: Theme.of(context).textTheme.headline1!.copyWith(),
              ),
              WButton(
                onTap: () {
                  StorageRepository.putString('language', 'en');
                  context.setLocale(const Locale('en'));
                },
                text: 'English',
                textStyle: Theme.of(context).textTheme.headline1!.copyWith(),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

class LanguageItem extends StatelessWidget {
  final bool isActive;
  final String title;
  final VoidCallback onSelect;
  const LanguageItem({
    required this.isActive,
    required this.title,
    required this.onSelect,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
