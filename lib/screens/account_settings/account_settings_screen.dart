import 'package:flutter/material.dart';
import 'package:med_g/bloc/bloc/authentication_bloc.dart';
import 'package:med_g/widgets/cached_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_g/widgets/w_app_bar.dart';
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
      body: Column(
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
            controller: nameController,
            onChanged: (_) {},
          ),
          WTextField(
            controller: nameController,
            onChanged: (_) {},
          ),
          WTextField(
            controller: nameController,
            onChanged: (_) {},
          ),
          WTextField(
            controller: nameController,
            onChanged: (_) {},
          ),
          WTextField(
            controller: nameController,
            onChanged: (_) {},
          ),
        ],
      ),
    );
  }
}
