import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:med_g/generated/locale_keys.g.dart';
import 'package:med_g/screens/calendar/parts/kvartal_item.dart';
import 'package:med_g/widgets/w_app_bar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const WAppBar(title: 'Kalendar'),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: const [
                SizedBox(
                  height: 16,
                ),
                KvartalItem(
                  kvartalNumber: 1,
                ),
                KvartalItem(
                  kvartalNumber: 2,
                ),
                KvartalItem(
                  kvartalNumber: 3,
                ),
                KvartalItem(
                  kvartalNumber: 4,
                )
                // TableCalendar(
                //   firstDay: DateTime.utc(2010, 10, 16),
                //   lastDay: DateTime.utc(2030, 3, 14),
                //   focusedDay: DateTime.now(),
                // )
              ],
            ),
          ),
        ),
      );
}
