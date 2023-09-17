import "package:flutter/foundation.dart";
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_model.freezed.dart'; //get the file name same as the class file name
part 'tag_model.g.dart';

@freezed
class Tag with _$Tag {
  const factory Tag({
    @Default('') @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'created_date') String? createdDate,
    @JsonKey(name: 'updated_date') String? updatedDate,
    @JsonKey(name: 'is_enabled') bool? isEnabled,
    @JsonKey(name: 'works_total') int? worksTotal,
  }) = _Tag;
  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}
