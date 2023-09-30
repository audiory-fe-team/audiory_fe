import 'package:audiory_v0/models/Chapter.dart';
import 'package:audiory_v0/models/Comment.dart';
import 'package:audiory_v0/models/Paragraph.dart';
import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/models/Tag.dart';
import 'package:audiory_v0/utils/fake_string_generator.dart';

final skeletonStory = Story(
    id: '',
    title: 'This is a fake title. This is a fake title.',
    voteCount: 1000,
    readCount: 1000,
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

final skeletonStories = [
  Story(id: '1', title: generateFakeString(20)),
  Story(id: '2', title: generateFakeString(15)),
  Story(id: '3', title: generateFakeString(25)),
  Story(id: '4', title: generateFakeString(23)),
  Story(id: '5', title: generateFakeString(33)),
];
final skeletonProfiles = [
  Profile(
      id: '1',
      fullName: generateFakeString(20),
      username: generateFakeString(10))
];

final skeletonChapter = Chapter(
    id: '1',
    storyId: '1',
    title: generateFakeString(30),
    readCount: 1000,
    voteCount: 1000,
    commentCount: 1000,
    paragraphs: [
      Paragraph(
          id: '1',
          chapterId: '1',
          order: 1,
          content: generateFakeString(2000),
          commentCount: 100,
          audioUrl: generateFakeString(50))
    ]);

final skeletonComments = [
  Comment(
      chapterId: '',
      id: '',
      paragraphId: '',
      createdDate: '2023-09-25T21:15:38+07:00',
      text: generateFakeString(60),
      userId: ''),
  Comment(
      chapterId: '',
      id: '',
      paragraphId: '',
      createdDate: '2023-09-25T21:15:38+07:00',
      text: generateFakeString(50),
      userId: ''),
  Comment(
      chapterId: '',
      id: '',
      paragraphId: '',
      createdDate: '2023-09-25T21:15:38+07:00',
      text: generateFakeString(60),
      userId: ''),
  Comment(
      chapterId: '',
      id: '',
      paragraphId: '',
      createdDate: '2023-09-25T21:15:38+07:00',
      text: generateFakeString(100),
      userId: ''),
  Comment(
      chapterId: '',
      id: '',
      paragraphId: '',
      createdDate: '2023-09-25T21:15:38+07:00',
      text: generateFakeString(20),
      userId: ''),
];
