import 'package:audiory_v0/models/Comment.dart';
import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/SearchStory.dart';
import 'package:audiory_v0/models/activity/activity_model.dart';
import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/models/notification/noti_model.dart';
import 'package:audiory_v0/models/paragraph/paragraph_model.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/models/tag/tag_model.dart';
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
    ],
    chapters: [
      Chapter(
          id: '1',
          storyId: '1',
          title: generateFakeString(30),
          readCount: 1000,
          voteCount: 1000,
          commentCount: 1000,
          paragraphs: [
            Paragraph(
                id: '1',
                chapterVersionId: '1',
                order: 1,
                content: generateFakeString(2000),
                commentCount: 100,
                audios: [])
          ]),
      Chapter(
          id: '2',
          storyId: '1',
          title: generateFakeString(30),
          readCount: 1000,
          voteCount: 1000,
          commentCount: 1000,
          paragraphs: [
            Paragraph(
                id: '1',
                chapterVersionId: '1',
                order: 1,
                content: generateFakeString(2000),
                commentCount: 100,
                audios: [])
          ]),
      Chapter(
          id: '2',
          storyId: '1',
          title: generateFakeString(30),
          readCount: 1000,
          voteCount: 1000,
          commentCount: 1000,
          paragraphs: [
            Paragraph(
                id: '1',
                chapterVersionId: '1',
                order: 1,
                content: generateFakeString(2000),
                commentCount: 100,
                audios: [])
          ])
    ]);

final skeletonStories = [
  Story(id: '1', title: generateFakeString(20), chapters: []),
  Story(id: '2', title: generateFakeString(15), chapters: []),
  Story(id: '3', title: generateFakeString(25), chapters: []),
  Story(id: '4', title: generateFakeString(23), chapters: []),
  Story(id: '5', title: generateFakeString(33), chapters: []),
];

final skeletonSearchStories = [
  SearchStory(
    id: '1',
    title: generateFakeString(20),
  ),
  SearchStory(
    id: '2',
    title: generateFakeString(15),
  ),
  SearchStory(
    id: '3',
    title: generateFakeString(25),
  ),
  SearchStory(
    id: '4',
    title: generateFakeString(23),
  ),
  SearchStory(
    id: '5',
    title: generateFakeString(33),
  ),
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
          chapterVersionId: '1',
          order: 1,
          content: generateFakeString(2000),
          commentCount: 100,
          audios: [])
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

final skeletonNotis = [
  Noti(
      id: 'abc',
      activity: const Activity(
          id: 'abc',
          actionEntity: 'haha',
          entityId: '1',
          userId: '1',
          actionType: 'COMMENTED'),
      content: generateFakeString(20)),
  Noti(
      id: 'abc',
      activity: const Activity(
          id: 'abc',
          actionEntity: 'haha',
          entityId: '1',
          userId: '1',
          actionType: 'COMMENTED'),
      content: generateFakeString(20)),
  Noti(
      id: 'abc',
      activity: const Activity(
          id: 'abc',
          actionEntity: 'haha',
          entityId: '1',
          userId: '1',
          actionType: 'COMMENTED'),
      content: generateFakeString(20)),
  Noti(
      id: 'abc',
      activity: const Activity(
          id: 'abc',
          actionEntity: 'haha',
          entityId: '1',
          userId: '1',
          actionType: 'COMMENTED'),
      content: generateFakeString(20)),
  Noti(
      id: 'abc',
      activity: const Activity(
          id: 'abc',
          actionEntity: 'haha',
          entityId: '1',
          userId: '1',
          actionType: 'COMMENTED'),
      content: generateFakeString(20)),
  Noti(
      id: 'abc',
      activity: const Activity(
          id: 'abc',
          actionEntity: 'haha',
          entityId: '1',
          userId: '1',
          actionType: 'COMMENTED'),
      content: generateFakeString(20)),
  Noti(
      id: 'abc',
      activity: const Activity(
          id: 'abc',
          actionEntity: 'haha',
          entityId: '1',
          userId: '1',
          actionType: 'COMMENTED'),
      content: generateFakeString(20)),
  Noti(
      id: 'abc',
      activity: const Activity(
          id: 'abc',
          actionEntity: 'haha',
          entityId: '1',
          userId: '1',
          actionType: 'COMMENTED'),
      content: generateFakeString(20)),
  Noti(
      id: 'abc',
      activity: const Activity(
          id: 'abc',
          actionEntity: 'haha',
          entityId: '1',
          userId: '1',
          actionType: 'COMMENTED'),
      content: generateFakeString(20)),
];
