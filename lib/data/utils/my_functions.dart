import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:med_g/app/constants/colors.dart';

class MyFunctions {
  static Widget _dotIndicator(Color color, int pageIndex, int id) =>
      AnimatedContainer(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: pageIndex == id ? 30 : 10,
        height: 8,
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: pageIndex == id ? color : color.withOpacity(0.4),
        ),
      );

  static List<Widget> indicatorBuilder(Color color, int index) {
    final list = <Widget>[];
    for (var e = 0; e < 3; e++) {
      list.add(_dotIndicator(color, index, e));
    }
    return list;
  }

  static String getFormattedCost(int cost) {
    var oldCost = cost.toString();
    var newCost = '';

    for (int i = 0; i < oldCost.length; i++) {
      if ((oldCost.length - i) % 3 == 0) newCost += " ";
      newCost += oldCost[i];
    }
    return newCost.trimLeft();
  }

  static String secondsToString(int seconds) {
    if (seconds ~/ 60 == 2) {
      return '02:00';
    } else if (seconds ~/ 60 == 1) {
      return '0${seconds ~/ 60}:${seconds - 60 < 10 ? '0${seconds - 60}' : seconds - 60}';
    } else if (seconds ~/ 60 == 0) {
      if (seconds == 0) {
        return '';
      }
      return '0${seconds ~/ 60}:${seconds < 10 ? '0$seconds' : seconds}';
    }
    return '';
  }

  static String formatPhoneNumber(String phone) {
    if (phone.isEmpty) {
      return '';
    }
    final formattedPhoneNumber =
        '${phone.substring(0, 2)} ${phone.substring(2, 5)} ${phone.substring(5, 7)} ${phone.substring(7, 9)}';
    return formattedPhoneNumber;
  }

  static Future<DateTime?> showDatePickerFunction(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate:
          DateTime(DateTime.now().subtract(const Duration(days: 5844)).year),
      firstDate:
          DateTime(DateTime.now().subtract(const Duration(days: 23741)).year),
      lastDate:
          DateTime(DateTime.now().subtract(const Duration(days: 5844)).year),
      builder: (_, child) => Theme(
        data: ThemeData.dark(),
        child: child!,
      ),
    );
    return date;
  }

  static int calculateWeekday(int weekId) {
    var number = weekId % 7;
    if (number == 0) {
      number = 7;
    }

    return number;
  }

  static Color getDayBackgroundColor(int weekDayId, BuildContext context) {
    switch (weekDayId) {
      case 6:
        return Theme.of(context).colorScheme.primary.withOpacity(0.1);
      case 7:
        return Theme.of(context).colorScheme.primary.withOpacity(0.1);
      default:
        return Colors.transparent;
    }
  }

  static Color getDayTextColor(int weekDayId, BuildContext context) {
    switch (weekDayId) {
      case 6:
        return Theme.of(context).colorScheme.primary;
      case 7:
        return Theme.of(context).colorScheme.primary;
      default:
        return dark.withOpacity(.8);
    }
  }

  static List<int> getMonthIndexes(int quarterId) {
    switch (quarterId) {
      case 1:
        return [1, 2, 3];
      case 2:
        return [4, 5, 6];
      case 3:
        return [7, 8, 9];
      case 4:
        return [10, 11, 12];
      default:
        return [];
    }
  }

  static String getMonthByIndex(int index) {
    switch (index) {
      case 1:
        return 'Yanvar';
      case 2:
        return 'Fevral';
      case 3:
        return 'Mart';
      case 4:
        return 'Aprel';
      case 5:
        return 'May';
      case 6:
        return 'Iyun';
      case 7:
        return 'Iyul';
      case 8:
        return 'Avgust';
      case 9:
        return 'Sentabr';
      case 10:
        return 'Oktabr';
      case 11:
        return 'Noyabr';
      case 12:
        return 'Dekabr';
      default:
        return '';
    }
  }
}
