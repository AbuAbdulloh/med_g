import 'package:flutter/material.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/data/singletons/storage.dart';
import 'package:med_g/widgets/w_bottomsheet.dart';
import 'package:med_g/widgets/w_button.dart';
import 'package:easy_localization/easy_localization.dart';

void showLanguageBottomSheet(BuildContext context) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      context: context,
      builder: (_) {
        return const LanguageBottomSheet();
      });
}

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  String? language;
  @override
  Widget build(BuildContext context) {
    return WBottomSheet(
      bottomNavigation: WButton(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        onTap: () {
          if (language != null && language!.isNotEmpty) {
            StorageRepository.putString('language', language!);
            context.setLocale(Locale(language!));
          }
          Navigator.of(context).pop();
        },
        text: 'Tasdiqlash',
        textStyle: Theme.of(context).textTheme.headline2!.copyWith(),
      ),
      children: [
        LanguageItem(
          isActive: language != null && language == 'uz',
          title: 'O’zbek tili',
          onSelect: () {
            selectLanguage('uz');
          },
        ),
        const Divider(),
        LanguageItem(
          isActive: language != null && language == 'ru',
          title: 'Русский',
          onSelect: () {
            selectLanguage('ru');
          },
        ),
        const Divider(),
        LanguageItem(
          isActive: language != null && language == 'en',
          title: 'English',
          onSelect: () {
            selectLanguage('en');
          },
        ),
      ],
    );
  }

  void selectLanguage(String language) {
    setState(() {
      this.language = language;
    });
  }
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onSelect,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 44,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: isActive ? primary.withOpacity(.4) : white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: isActive
              ? Theme.of(context).textTheme.headline2!.copyWith()
              : Theme.of(context).textTheme.headline1!.copyWith(),
        ),
      ),
    );
  }
}
