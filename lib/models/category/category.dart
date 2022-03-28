import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(createToJson: false)
class CategoryResponse extends Equatable {
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'slug', defaultValue: '')
  final String slug;
  @JsonKey(name: 'created_at', defaultValue: '')
  final String createdAt;
  @JsonKey(name: 'thumbnail', defaultValue: '')
  final String thumbnail;

  const CategoryResponse({
    required this.id,
    required this.name,
    required this.slug,
    required this.createdAt,
    required this.thumbnail,
  }) : super();

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);
  @override
  String toString() {
    return 'CategoryResponse(id: $id, name: $name, slug: $slug, createdAt: $createdAt, thumbnail: $thumbnail)';
  }

  @override
  List<Object> get props {
    return [id, name, slug, createdAt, thumbnail];
  }
}
