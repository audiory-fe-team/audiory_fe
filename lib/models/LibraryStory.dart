import 'package:audiory_v0/models/ReadingProgress.dart';
import 'package:audiory_v0/models/Story.dart';

class LibraryStory {
  final bool? isAvailableOffline;
  final bool? isPinned;
  final String? lastReadDate;
  final String? lastSyncTimestamp;
  final String? libraryId;
  final ReadingProgress? readingProgress;
  final String storyId;
  final Story story;

  LibraryStory({
    this.isAvailableOffline,
    this.isPinned,
    this.lastReadDate,
    this.lastSyncTimestamp,
    this.libraryId,
    this.readingProgress,
    required this.storyId,
    required this.story,
  });

  factory LibraryStory.fromJson(Map<String, dynamic> json) {
    return LibraryStory(
      isAvailableOffline: json['is_available_offline'],
      isPinned: json['is_pinned'],
      lastReadDate: json['last_read_date'],
      lastSyncTimestamp: json['last_sync_timestamp'],
      libraryId: json['library_id'],
      readingProgress: json['reading_progress'] == null
          ? null
          : ReadingProgress.fromJson(json['reading_progress']),
      storyId: json['story_id'],
      story: Story.fromJson(json['story']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_available_offline': isAvailableOffline,
      'is_pinned': isPinned,
      'last_read_date': lastReadDate,
      'last_sync_timestamp': lastSyncTimestamp,
      'library_id': libraryId,
      'reading_progress': readingProgress?.toJson(),
      'story_id': storyId,
      'story': story.toJson(),
    };
  }
}
