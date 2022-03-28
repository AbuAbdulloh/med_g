// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_single.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleSingle _$ArticleSingleFromJson(Map<String, dynamic> json) =>
    ArticleSingle(
      id: json['id'] as String? ?? '',
      category: json['category'] == null
          ? null
          : CategoryResponse.fromJson(json['category'] as Map<String, dynamic>),
      author: json['author'] as String? ?? '',
      content: json['content'] as String? ?? '',
      saved: json['saved'] as bool? ?? false,
      createdAt: json['craeted_at'] as String? ?? '',
    );
