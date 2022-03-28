import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/bloc/bloc/authentication_bloc.dart';
import 'package:med_g/widgets/cached_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_g/widgets/w_app_bar.dart';
import 'package:med_g/widgets/w_scale_animation.dart';
import 'package:med_g/widgets/w_textfield.dart';

class AccountSettings extends StatefulWidget {
  static Route route() => MaterialPageRoute(
        builder: (_) => const AccountSettings(),
      );
  const AccountSettings({Key? key}) : super(key: key);

  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  late TextEditingController nameController;
  late TextEditingController hobbyController;
  late TextEditingController regionController;
  late TextEditingController heightController;
  late TextEditingController weightController;
  late TextEditingController alleryController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    hobbyController = TextEditingController();
    regionController = TextEditingController();
    heightController = TextEditingController();
    weightController = TextEditingController();
    alleryController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    hobbyController.dispose();
    regionController.dispose();
    heightController.dispose();
    weightController.dispose();
    alleryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WAppBar(
        title: 'Profil ma’lumotlari',
        hasBackButton: true,
        isTitleCentered: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              width: 80,
              height: 80,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: CachedImage(
                fit: BoxFit.cover,
                url: context.read<AuthenticationBloc>().state.user.image,
                width: 80,
                height: 80,
              ),
            ),
            WTextField(
              title: 'F.I.Sh.',
              titleTextStyle: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
              fillColor: white,
              hasBorderColor: true,
              controller: nameController,
              onChanged: (_) {},
            ),
            WTextField(
              title: 'Qiziqishlar',
              titleTextStyle: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
              fillColor: white,
              controller: nameController,
              onChanged: (_) {},
            ),
            WTextField(
              title: 'Hudud (ixtiyoriy)',
              titleTextStyle: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
              fillColor: white,
              controller: nameController,
              onChanged: (_) {},
            ),
            WTextField(
              title: 'Bo’y uzunligi',
              titleTextStyle: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
              fillColor: white,
              controller: nameController,
              onChanged: (_) {},
            ),
            WTextField(
              title: 'Vazn og’irligi',
              titleTextStyle: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
              fillColor: white,
              controller: nameController,
              onChanged: (_) {},
            ),
            Text(
              'Tug‘ilgan sana',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            WScaleAnimation(
              onTap: () {
                showBottomSheet(
                  context: context,
                  builder: (_) {
                    return DatePickerDialog(
                      initialDate:
                          DateTime.now().subtract(const Duration(days: 36500)),
                      lastDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 31)),
                    );
                  },
                );
              },
              scaleValue: 0.99,
              child: Container(
                height: 48,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: white,
                  border: Border.all(width: 1, color: stroke),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'KK/OO/YYYY',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    SvgPicture.asset(AppIcons.calendar)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
