import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_category.g.dart';

@JsonSerializable(createToJson: false)
class ArticleCategory extends Equatable {
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'slug', defaultValue: '')
  final String slug;
  @JsonKey(name: 'created_at', defaultValue: '')
  final String createdAt;

  const ArticleCategory({
    required this.id,
    required this.name,
    required this.slug,
    required this.createdAt,
  });

  factory ArticleCategory.fromJson(Map<String, dynamic> json) =>
      _$ArticleCategoryFromJson(json);

  @override
  List<Object> get props => [id, name, slug, createdAt];

  @override
  String toString() {
    return 'ArticleCategory(id: $id, name: $name, slug: $slug, createdAt: $createdAt)';
  }
}
