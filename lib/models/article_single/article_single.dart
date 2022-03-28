import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:med_g/models/category/category.dart';

part 'article_single.g.dart';

@JsonSerializable(createToJson: false)
class ArticleSingle extends Equatable {
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'category')
  final CategoryResponse? category;
  @JsonKey(name: 'author', defaultValue: '')
  final String author;
  @JsonKey(name: 'content', defaultValue: '')
  final String content;
  @JsonKey(name: 'saved', defaultValue: false)
  final bool saved;
  @JsonKey(name: 'craeted_at', defaultValue: '')
  final String createdAt;

  const ArticleSingle({
    required this.id,
    required this.category,
    required this.author,
    required this.content,
    required this.saved,
    required this.createdAt,
  });

  factory ArticleSingle.fromJson(Map<String, dynamic> json) =>
      _$ArticleSingleFromJson(json);

  @override
  List<Object?> get props {
    return [
      id,
      category,
      author,
      content,
      saved,
      createdAt,
    ];
  }

  @override
  String toString() {
    return 'ArticleSingle(id: $id, category: $category, author: $author, content: $content, saved: $saved, createdAt: $createdAt)';
  }
}
