import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/bloc/bloc/authentication_bloc.dart';
import 'package:med_g/repository/authentication.dart';
import 'package:med_g/screens/account_settings/bloc/profile_bloc.dart';
import 'package:med_g/widgets/cached_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_g/widgets/w_app_bar.dart';
import 'package:med_g/widgets/w_bottomsheet.dart';
import 'package:med_g/widgets/w_button.dart';
import 'package:med_g/widgets/w_error_snack_bar.dart';
import 'package:med_g/widgets/w_scale_animation.dart';
import 'package:med_g/widgets/w_textarea.dart';
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
  late TextEditingController allergyController;

  File? image;
  DateTime? date;
  ImageSource? imageSource;
  late ProfileBloc profileBloc;
  @override
  void initState() {
    super.initState();
    final user = context.read<AuthenticationBloc>().state.user;
    profileBloc = ProfileBloc(
      repository: RepositoryProvider.of<AuthenticationRepository>(context),
    );
    nameController = TextEditingController(text: user.firstName);
    hobbyController = TextEditingController(text: user.hobby);
    regionController = TextEditingController(text: user.address);
    heightController = TextEditingController(text: '${user.height}');
    weightController = TextEditingController(text: '${user.weight}');
    allergyController = TextEditingController(text: user.allergy);
  }

  @override
  void dispose() {
    nameController.dispose();
    hobbyController.dispose();
    regionController.dispose();
    heightController.dispose();
    weightController.dispose();
    allergyController.dispose();
    super.dispose();
    profileBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: BlocProvider.value(
        value: profileBloc,
        child: Scaffold(
          appBar: const WAppBar(
            title: 'Profil ma’lumotlari',
            hasBackButton: true,
            isTitleCentered: true,
          ),
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      child: Container(
                        margin: const EdgeInsets.only(top: 4),
                        clipBehavior: Clip.hardEdge,
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Stack(
                          children: [
                            image == null
                                ? CachedImage(
                                    fit: BoxFit.cover,
                                    url: context
                                        .read<AuthenticationBloc>()
                                        .state
                                        .user
                                        .image,
                                    width: 80,
                                    height: 80,
                                  )
                                : Image.file(
                                    image!,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Row(
                                        children: [
                                          Text(
                                            'Manba tanlash',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1!
                                                .copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          const Spacer(),
                                          WScaleAnimation(
                                            child: SvgPicture.asset(
                                                AppIcons.closeGreen),
                                            onTap: () {
                                              Navigator.pop(_);
                                            },
                                          ),
                                        ],
                                      ),
                                      content: Text(
                                        'Qaysi manbadan foydalanishni istaysiz?',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3!
                                            .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      actions: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: WButton(
                                                onTap: () {
                                                  pickImage(
                                                    context: _,
                                                    source: ImageSource.camera,
                                                  );
                                                },
                                                text: 'Kamera',
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .headline2!
                                                    .copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: WButton(
                                                onTap: () {
                                                  pickImage(
                                                    context: _,
                                                    source: ImageSource.gallery,
                                                  );
                                                },
                                                text: 'Galereya',
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .headline2!
                                                    .copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Container(
                                  color: dark.withOpacity(0.5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(25),
                                    child: SvgPicture.asset(AppIcons.editPen),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: WTextField(
                        title: 'F.I.Sh.',
                        titleTextStyle:
                            Theme.of(context).textTheme.headline1!.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                        hintText: 'Ismingizni kiriting',
                        hintTextStyle:
                            Theme.of(context).textTheme.headline3!.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                        fillColor: white,
                        hasBorderColor: true,
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        onChanged: (_) {},
                      ),
                    ),
                    WTextField(
                      title: 'Qiziqishlar',
                      titleTextStyle:
                          Theme.of(context).textTheme.headline1!.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                      hintText: 'Hobbilaringizni kiriting',
                      hintTextStyle:
                          Theme.of(context).textTheme.headline3!.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                      fillColor: white,
                      hasBorderColor: true,
                      controller: hobbyController,
                      onChanged: (_) {},
                      textInputAction: TextInputAction.next,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: WTextField(
                        title: 'Hudud (ixtiyoriy)',
                        titleTextStyle:
                            Theme.of(context).textTheme.headline1!.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                        hintText: 'Hududni kiriting',
                        hintTextStyle:
                            Theme.of(context).textTheme.headline3!.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                        fillColor: white,
                        hasBorderColor: true,
                        controller: regionController,
                        onChanged: (_) {},
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    WTextField(
                      title: 'Bo’y uzunligi',
                      titleTextStyle:
                          Theme.of(context).textTheme.headline1!.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                      hintText: 'Bo’y uzunligini kiriting',
                      hintTextStyle:
                          Theme.of(context).textTheme.headline3!.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                      fillColor: white,
                      hasBorderColor: true,
                      controller: heightController,
                      onChanged: (_) {},
                      textInputAction: TextInputAction.next,
                      keyBoardType: TextInputType.number,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: WTextField(
                        title: 'Vazn og’irligi',
                        titleTextStyle:
                            Theme.of(context).textTheme.headline1!.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                        hintText: 'Vazningizni kiriting',
                        hintTextStyle:
                            Theme.of(context).textTheme.headline3!.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                        fillColor: white,
                        hasBorderColor: true,
                        controller: weightController,
                        onChanged: (_) {},
                        textInputAction: TextInputAction.next,
                        keyBoardType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tug‘ilgan sana',
                            style:
                                Theme.of(context).textTheme.headline1!.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          const SizedBox(height: 8),
                          WScaleAnimation(
                            onTap: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                useRootNavigator: true,
                                context: context,
                                builder: (_) {
                                  return WBottomSheet(
                                    children: [
                                      DateTimePickerWidget(
                                        dateFormat: 'dd MMMM yyyy',
                                        onConfirm: (date, _) {
                                          setState(() {
                                            this.date = date;
                                          });
                                        },
                                      ),
                                    ],
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    date == null
                                        ? 'KK/OO/YYYY'
                                        : Jiffy(date).format('dd/MM/yyyy'),
                                    style: date == null
                                        ? Theme.of(context)
                                            .textTheme
                                            .headline3!
                                            .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            )
                                        : Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                  ),
                                  SvgPicture.asset(AppIcons.calendar)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Allergiya (ixtiyoriy)',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 8),
                    WTextArea(
                      controller: allergyController,
                      onChanged: (_) {},
                      hintText: 'Nimalarga allergiyangiz bor?',
                    ),
                    WButton(
                      loading: state.status == FormzStatus.submissionInProgress,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      onTap: () {
                        final user =
                            context.read<AuthenticationBloc>().state.user;
                        profileBloc.add(
                          UpdateProfile(
                              user: user.copyWith(
                                address: regionController.text.trim(),
                                firstName: nameController.text.trim(),
                                hobby: hobbyController.text.trim(),
                                height: double.parse(heightController.text.trim()),
                                weight: double.parse(weightController.text.trim()),
                                allergy: allergyController.text.trim(),
                                patronymic: allergyController.text.trim(),
                                birthDate: date == null
                                    ? user.birthDate
                                    : date!.toIso8601String(),
                              ),
                              onSucces: () {
                                print(state.user);
                                context.read<AuthenticationBloc>().add(
                                      AuthenticationUserUpdated(
                                        user: state.user,
                                        onSucces: () {
                                          print('success changed profile');
                                        },
                                      ),
                                    );
                                if (image == null) {}
                              },
                              onError: (message) {
                                showErrorSnackBar(context, message);
                              }),
                        );
                      },
                      text: 'Saqlash',
                      textStyle:
                          Theme.of(context).textTheme.headline2!.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void pickImage({
    required BuildContext context,
    required ImageSource? source,
  }) async {
    if (source == null) {
      Navigator.pop(context);
    } else {
      final file = await ImagePicker().pickImage(source: source);
      if (file != null) {
        setState(() {
          image = File(file.path);
        });
      }
      Navigator.pop(context);
    }
  }
}
