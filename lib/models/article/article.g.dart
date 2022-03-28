// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      id: json['id'] as String? ?? '',
      category:
          ArticleCategory.fromJson(json['category'] as Map<String, dynamic>),
      author: json['author'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      thumbnail: json['thumbnail'] as String? ?? '',
      saved: json['saved'] as bool? ?? false,
      createdAt: json['created_at'] as String? ?? '',
    );
