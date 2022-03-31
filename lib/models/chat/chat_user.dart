import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:med_g/models/category/category.dart';

part 'chat_user.g.dart';

@JsonSerializable()
class ChatUser extends Equatable {
  @JsonKey(name: 'id', defaultValue: 0)
  final int id;
  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'avatar_url', defaultValue: '')
  final String avatarUrl;
  @JsonKey(name: 'category')
  final CategoryResponse? category;
  @JsonKey(name: 'online', defaultValue: false)
  final bool online;

  ChatUser(
      {required this.avatarUrl,
      required this.category,
      required this.id,
      required this.name,
      required this.online});

  factory ChatUser.fromJson(Map<String, dynamic> json) =>
      _$ChatUserFromJson(json);

  ChatUser copyWith({bool? online}) => ChatUser(
      category: category,
      avatarUrl: avatarUrl,
      id: id,
      name: name,
      online: online ?? this.online);

  @override
  List<Object?> get props => [online, category];
}
