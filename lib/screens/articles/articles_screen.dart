import 'package:flutter/material.dart';
import 'package:med_g/screens/main/widgets/article_item.dart';
import 'package:med_g/screens/main/widgets/main_app_bar.dart';

class ArtclesScreen extends StatefulWidget {
  const ArtclesScreen({Key? key}) : super(key: key);

  @override
  State<ArtclesScreen> createState() => _ArtclesScreenState();
}

class _ArtclesScreenState extends State<ArtclesScreen> {
  late TextEditingController searchController;
  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          MainAppBar(searchController: searchController),
        ],
        body: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemBuilder: (_, index) => const ArticleItem(),
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemCount: 10,
        ),
      ),
    );
  }
}
