import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:med_g/models/article/article_category.dart';

part 'article.g.dart';

@JsonSerializable(createToJson: false)
class Article extends Equatable {
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'category')
  final ArticleCategory category;
  @JsonKey(name: 'author', defaultValue: '')
  final String author;
  @JsonKey(name: 'title', defaultValue: '')
  final String title;
  @JsonKey(name: 'description', defaultValue: '')
  final String description;
  @JsonKey(name: 'thumbnail', defaultValue: '')
  final String thumbnail;
  @JsonKey(name: 'saved', defaultValue: false)
  final bool saved;
  @JsonKey(name: 'created_at', defaultValue: '')
  final String createdAt;

  const Article({
    required this.id,
    required this.category,
    required this.author,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.saved,
    required this.createdAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
  @override
  List<Object> get props {
    return [
      id,
      category,
      author,
      title,
      description,
      thumbnail,
      saved,
      createdAt
    ];
  }

  @override
  String toString() {
    return 'Article(id: $id, category: $category, author: $author, title: $title, description: $description, thumbnail: $thumbnail, saved: $saved, createdAt: $createdAt)';
  }

  Article copyWith({
    String? id,
    ArticleCategory? category,
    String? author,
    String? title,
    String? description,
    String? thumbnail,
    bool? saved,
    String? createdAt,
  }) {
    return Article(
      id: id ?? this.id,
      category: category ?? this.category,
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
      saved: saved ?? this.saved,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
