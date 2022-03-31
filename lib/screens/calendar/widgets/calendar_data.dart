import 'package:flutter/material.dart'
    '';
import 'package:jiffy/jiffy.dart';
import 'package:med_g/data/utils/my_functions.dart';
import 'package:med_g/screens/calendar/widgets/calendar_day_box.dart';

class CalendarData extends StatelessWidget {
  final Jiffy month;

  const CalendarData({
    required this.month,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 8),
        child: Wrap(runSpacing: 8, spacing: 8, children: [
          ...List.generate(
              month.dateTime.weekday > 1 ? month.dateTime.weekday - 1 : 0,
              (index) => const SizedBox(
                    height: 42,
                    width: 42,
                  )),
          ...List.generate(
            month.daysInMonth,
            (index) => CalendarDayBox(
                day: index + 1,
                weekDayId: MyFunctions.calculateWeekday(
                    month.dateTime.weekday + index)),
          ),
        ]),
      );
}
