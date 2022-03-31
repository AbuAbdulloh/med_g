import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/app_images.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/widgets/w_scale_animation.dart';

class SupportScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(
        builder: (_) => const SupportScreen(key: Key('about-screen')),
      );
  const SupportScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, isExpanded) => [
          SliverAppBar(
            elevation: 2,
            shadowColor: black.withOpacity(0.25),
            pinned: true,
            toolbarHeight: 56,
            backgroundColor: white,
            titleSpacing: 0,
            expandedHeight: MediaQuery.of(context).padding.top + 238,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              expandedTitleScale: 1,
              titlePadding: EdgeInsets.zero,
              title: Padding(
                padding: const EdgeInsets.only(left: 50, bottom: 16),
                child: Text(
                  '',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              background: Image.asset(
                AppImages.services,
                fit: BoxFit.cover,
                height: double.maxFinite,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            leading: WScaleAnimation(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SvgPicture.asset(AppIcons.arrowLeft),
              ),
            ),
          )
        ],
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(12),
                  right: Radius.circular(12),
                )),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MedG haqida',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'MEdG jamoasi',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  Text(
                    '''
MedG HAQIDA

Tadqiqotlarga ko‘ra, XIX asrning ikkinchi yarmi va XX asr boshlarida ma'rifatparvar ajdodlarimiz yaratgan pedagogik asarlarning aksariyatida bolani jismoniy jihatdan sog‘lom etib tarbiyalashga alohida e'tibor qaratilgan.

JAMOAMIZ HAQIDA

Jumladan, bu borada Abdurauf Fitratning ijtimoiy tarbiya negizida jismoniy tarbiyani tashkil etish, shaxsni salomat va baquvvat etib tarbiyalash masalalariga oid qarashlari diqqatga molikdir. Uning «Rahbari najot» asarining «Bola tarbiyasi» nomli bobida shunday deyiladi: «Badan tarbiyasiga qadim zamonlardan boshlab katta ahamiyat berilgan. Insonning butun a'zosi salomat va quvvatga ega bo‘lmasa, unda inson uzoq yashamaydi. Agar insonning tanasidagi a'zolaridan biriga xalal tegsa, u kishi ishdan qo‘lini tortib, boshqalarning muhtojiga aylanadi».

FAQ
''',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
