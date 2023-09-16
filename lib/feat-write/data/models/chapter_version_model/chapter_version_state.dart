//chapter state for controlling isloading

import 'package:freezed_annotation/freezed_annotation.dart';

import 'chapter_version_model.dart';

part 'chapter_version_state.freezed.dart';

@freezed
class ChapterVersionState with _$ChapterVersionState {
  factory ChapterVersionState({
    @Default(ChapterVersion()) ChapterVersion chapterVersion,
    @Default(true) bool isLoading,
  }) = _ChapterVersionState;
}
