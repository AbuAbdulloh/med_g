// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_single.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategorySingle _$CategorySingleFromJson(Map<String, dynamic> json) =>
    CategorySingle(
      articles: (json['articles'] as List<dynamic>?)
              ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      category:
          CategoryResponse.fromJson(json['category'] as Map<String, dynamic>),
    );
