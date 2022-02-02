
import 'package:flutter/material.dart';
import 'package:med_g/app/theme/theme.dart';

class AccountSettingsItem extends StatelessWidget {
  final String title;
  final String text;
  const AccountSettingsItem({
    required this.title,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(
        horizontal: 19.5,
        vertical: 20.5,
      ),
      decoration: const BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
