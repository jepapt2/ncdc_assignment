import 'package:freezed_annotation/freezed_annotation.dart';

part 'content.freezed.dart';
part 'content.g.dart';

@freezed
class Content with _$Content {
  const factory Content({
    required int id,
    String? title,
    String? body,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Content;

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
}

@freezed
class CreateContentDTO with _$CreateContentDTO {
  const factory CreateContentDTO({
    String? title,
    String? body,
  }) = _CreateContentDTO;

  factory CreateContentDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateContentDTOFromJson(json);
}
