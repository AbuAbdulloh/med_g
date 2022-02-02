import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/widgets/w_app_bar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime? _currentDate;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: PreferredSize(
        child: WAppBar(title: 'Calendar', mediaQuery: mediaQuery),
        preferredSize: Size.fromHeight(mediaQuery.padding.top + 77),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppTheme.black.withOpacity(0.2),
                blurRadius: 3,
                offset: const Offset(1, 2),
              )
            ],
          ),
          child: CalendarCarousel(
            onDayPressed: (DateTime date, List events) {
              setState(() => _currentDate = date);
            },
            weekendTextStyle: const TextStyle(
              color: Colors.red,
            ),
            thisMonthDayBorderColor: Colors.grey,
            customDayBuilder: (
              bool isSelectable,
              int index,
              bool isSelectedDay,
              bool isToday,
              bool isPrevMonthDay,
              TextStyle textStyle,
              bool isNextMonthDay,
              bool isThisMonthDay,
              DateTime day,
            ) {
              if (day.day == 15) {
                return const Center(
                  child: Icon(Icons.local_airport),
                );
              } else {
                return null;
              }
            },
            weekFormat: false,
            markedDatesMap: null,
            height: 420.0,
            selectedDateTime: _currentDate,
            daysHaveCircularBorder: false,
          ),
        ),
      ),
    );
  }
}
