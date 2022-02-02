import 'package:flutter/material.dart';
import 'package:med_g/screens/review_details/widgets/review_details_item.dart';
import 'package:med_g/widgets/w_app_bar.dart';

class ReviewDetails extends StatelessWidget {
  final String name;
  final String time;
  final List<Widget> items;
  const ReviewDetails({
    required this.name,
    required this.time,
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: PreferredSize(
        child: WAppBar(title: 'Review Details', mediaQuery: mediaQuery),
        preferredSize: Size.fromHeight(mediaQuery.padding.top + 77),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 38, left: 14, right: 14),
        child: ReviewDetailsItem(
          name: name,
          time: time,
          items: items,
        ),
      ),
    );
  }
}
