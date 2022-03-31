import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final String title;
  final EdgeInsets? margin;

  final String value;

  const InfoRow({
    required this.title,
    required this.value,
    this.margin,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: margin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ],
        ),
      );
}
