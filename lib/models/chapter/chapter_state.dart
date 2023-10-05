//chapter state for controlling isloading

import 'package:freezed_annotation/freezed_annotation.dart';

import 'chapter_model.dart';

part 'chapter_state.freezed.dart';

@freezed
class ChapterState with _$ChapterState {
  factory ChapterState({
    @Default(Chapter()) Chapter chapter,
    @Default(true) bool isLoading,
  }) = _ChapterState;
}
