import 'package:flutter/material.dart';

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
}
