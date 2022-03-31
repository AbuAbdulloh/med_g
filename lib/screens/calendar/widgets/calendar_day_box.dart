import 'package:flutter/material.dart';
import 'package:med_g/data/utils/my_functions.dart';

enum DayType { holiday, preHoliday, weekend }

class CalendarDayBox extends StatelessWidget {
  final int day;
  final int weekDayId;

  const CalendarDayBox({
    required this.day,
    required this.weekDayId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
            color: MyFunctions.getDayBackgroundColor(weekDayId, context),
            borderRadius: BorderRadius.circular(4)),
        child: Center(
          child: Text(
            day.toString(),
            style: Theme.of(context).textTheme.headline1!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: MyFunctions.getDayTextColor(weekDayId, context)),
          ),
        ),
      );
}
