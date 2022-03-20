import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/bloc/bloc/authentication_bloc.dart';
import 'package:med_g/models/authentication_status/authentication_status.dart';
import 'package:med_g/screens/login/login_screen.dart';
import 'package:med_g/widgets/w_app_bar.dart';
import 'package:med_g/widgets/w_button.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime? _currentDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (_, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          return Scaffold(
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
                  color: white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: black.withOpacity(0.2),
                      blurRadius: 3,
                      offset: const Offset(1, 2),
                    ),
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
        } else {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIcons.noAccount),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Для полноценного использования войдите в аккаунт',
                          style: theme.headline1!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                WButton(
                  margin: const EdgeInsets.all(16),
                  text: 'Войти',
                  textStyle: theme.headline2!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .push(LoginScreen.route());
                  },
                )
              ],
            ),
          );
        }
      },
    );
  }
}
