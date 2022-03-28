import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:med_g/models/article/article.dart';
import 'package:med_g/models/category/category.dart';

part 'category_single.g.dart';

@JsonSerializable(createToJson: false)
class CategorySingle extends Equatable {
  @JsonKey(name: 'articles', defaultValue: [])
  final List<Article> articles;
  @JsonKey(name: 'category')
  final CategoryResponse category;

  const CategorySingle({
    required this.articles,
    required this.category,
  });

  factory CategorySingle.fromJson(Map<String, dynamic> json) =>
      _$CategorySingleFromJson(json);

  @override
  List<Object> get props => [articles, category];

  @override
  String toString() =>
      'CategorySingle(articles: $articles, category: $category)';
}
