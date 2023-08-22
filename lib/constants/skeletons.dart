import 'package:audiory_v0/models/Chapter.dart';
import 'package:audiory_v0/models/Paragraph.dart';
import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/models/Tag.dart';
import 'package:audiory_v0/utils/fake_string_generator.dart';

final skeletonStory = Story(
    id: '',
    title: 'This is a fake title. This is a fake title.',
    vote_count: 1000,
    read_count: 1000,
    description: generateFakeString(400),
    tags: [
      Tag(id: '1', name: generateFakeString(7)),
      Tag(id: '2', name: generateFakeString(5)),
      Tag(id: '3', name: generateFakeString(3)),
      Tag(id: '4', name: generateFakeString(5)),
      Tag(id: '5', name: generateFakeString(1)),
      Tag(id: '6', name: generateFakeString(3)),
      Tag(id: '8', name: generateFakeString(7))
    ]);

final skeletonStories = [Story(id: '1', title: generateFakeString(20))];
final skeletonProfiles = [
  Profile(
      id: '1',
      fullName: generateFakeString(20),
      username: generateFakeString(10))
];

final skeletonChapter = Chapter(
    id: '1',
    story_id: '1',
    title: generateFakeString(30),
    read_count: 1000,
    vote_count: 1000,
    comment_count: 1000,
    paragraphs: [
      Paragraph(
          id: '1',
          chapter_id: '1',
          order: 1,
          content: generateFakeString(200),
          comment_count: 100,
          audio_url: generateFakeString(50))
    ]);
