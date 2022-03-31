import 'package:flutter/material.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/data/utils/my_functions.dart';
import 'package:med_g/screens/calendar/parts/calendar.dart';
import 'package:med_g/screens/calendar/widgets/data_row.dart';
import 'package:med_g/widgets/w_button.dart';

class KvartalItem extends StatefulWidget {
  final int kvartalNumber;

  const KvartalItem({
    required this.kvartalNumber,
    Key? key,
  }) : super(key: key);

  @override
  State<KvartalItem> createState() => _KvartalItemState();
}

class _KvartalItemState extends State<KvartalItem> {
  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(
                'Coming soon',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              content: Text(
                'These features are coming soon...',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              actions: [
                WButton(
                  onTap: () {
                    Navigator.pop(_);
                  },
                  text: 'Close',
                )
              ],
            ),
          );
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: Colors.white),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fasliy Sog`lik hisoboti',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 18),
                    child: const Divider(
                      color: stroke,
                    ),
                  ),
                  const InfoRow(
                    title: 'Kalendar kunlari',
                    value: '24',
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                  const InfoRow(
                    title: 'Bayram kunlari',
                    value: '21',
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                  const InfoRow(
                    title: 'Ish kunlari',
                    value: '43',
                    margin: EdgeInsets.only(bottom: 20),
                  ),
                  const InfoRow(
                    title: 'Davolanish davomiyligi',
                    value: '24',
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                  const InfoRow(
                    title: 'Kasallanishlar',
                    value: '21',
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                  const InfoRow(
                    title: 'Kasallanish kunlari',
                    value: '43',
                    margin: EdgeInsets.only(bottom: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            CustomCalendar(
                dateTimeMonths:
                    MyFunctions.getMonthIndexes(widget.kvartalNumber)),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      );
}
