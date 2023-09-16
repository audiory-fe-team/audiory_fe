//create provider for api and repository

import 'package:audiory_v0/core/shared_provider/shared_provider.dart';
import 'package:audiory_v0/feat-write/data/repositories/chapter_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/api/chapter_api.dart';

final chapterApiProvider = Provider<ChapterApi>((ref) {
  return ChapterApi(ref.read(dioClientProvider));
});

final chapterRepositoryProvider = Provider<ChapterRepository>((ref) {
  return ChapterRepository(ref.read(chapterApiProvider));
});
