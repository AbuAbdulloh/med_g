import 'package:flutter/material.dart';
import 'package:med_g/screens/category_single/widgets/category_app_bar.dart';
import 'package:med_g/screens/main/widgets/article_item.dart';
import 'package:med_g/screens/main/widgets/main_app_bar.dart';

class CategorySingleScreen extends StatefulWidget {
  final String title;
  const CategorySingleScreen({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  State<CategorySingleScreen> createState() => _CategorySingleScreenState();
}

class _CategorySingleScreenState extends State<CategorySingleScreen> {
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
          CategoryAppBar(
            searchController: searchController,
            title: widget.title,
          ),
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
