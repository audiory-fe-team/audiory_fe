import 'package:audiory_v0/models/Author.dart';
import 'package:audiory_v0/models/Story.dart';

const List<Story> STORIES = [
  Story(
    id: 1,
    authorName: 'John Doe',
    tags: ['fantasy', 'adventure'],
    categoryId: 1,
    title: 'The Quest for the Magical Amulet',
    description:
        'Join our heroes on an epic quest to find the magical amulet and save the world.',
    coverUrl:
        'https://res.cloudinary.com/ddvdxx85g/image/upload/v1678858100/samples/animals/cat.jpg',
    isDraft: false,
    isMature: false,
    numChapter: 10,
    readCount: 500,
    voteCount: 100,
  ),
  Story(
    id: 2,
    authorName: 'Jane Smith',
    tags: ['romance', 'drama'],
    categoryId: 2,
    title: 'Love in Paris',
    description:
        'https://res.cloudinary.com/ddvdxx85g/image/upload/v1678858100/samples/animals/cat.jpg',
    coverUrl:
        'https://res.cloudinary.com/ddvdxx85g/image/upload/v1678858100/samples/animals/cat.jpg',
    isDraft: false,
    isMature: false,
    numChapter: 20,
    readCount: 1000,
    voteCount: 250,
  ),
  Story(
    id: 3,
    authorName: 'Mark Johnson',
    tags: ['science fiction'],
    categoryId: 1,
    title: 'The Quantum Nexus',
    description:
        'https://res.cloudinary.com/ddvdxx85g/image/upload/v1678858100/samples/animals/cat.jpg',
    coverUrl:
        'https://res.cloudinary.com/ddvdxx85g/image/upload/v1678858100/samples/animals/cat.jpg',
    isDraft: false,
    isMature: false,
    numChapter: 15,
    readCount: 800,
    voteCount: 180,
  ),
  Story(
    id: 4,
    authorName: 'Emily Wilson',
    tags: ['mystery', 'thriller'],
    categoryId: 3,
    title: 'The Secrets of Ravenbrook Manor',
    description:
        'Unravel the dark secrets that lie within the walls of Ravenbrook Manor.',
    coverUrl:
        'https://res.cloudinary.com/ddvdxx85g/image/upload/v1678858100/samples/animals/cat.jpg',
    isDraft: false,
    isMature: false,
    numChapter: 25,
    readCount: 1200,
    voteCount: 300,
  ),
  Story(
    id: 5,
    authorName: 'Sarah Adams',
    tags: ['fantasy', 'magic'],
    categoryId: 1,
    title: 'The Enchanted Forest',
    description:
        'Embark on a magical journey through an enchanted forest filled with mystical creatures.',
    coverUrl:
        'https://res.cloudinary.com/ddvdxx85g/image/upload/v1678858100/samples/animals/cat.jpg',
    isDraft: false,
    isMature: false,
    numChapter: 12,
    readCount: 700,
    voteCount: 150,
  ),
  Story(
    id: 6,
    authorName: 'Michael Carter',
    tags: ['sci-fi', 'action'],
    categoryId: 1,
    title: 'Galactic Warriors',
    description:
        'Join a team of elite warriors as they defend the galaxy against alien invaders.',
    coverUrl:
        'https://res.cloudinary.com/ddvdxx85g/image/upload/v1678858100/samples/animals/cat.jpg',
    isDraft: false,
    isMature: false,
    numChapter: 18,
    readCount: 900,
    voteCount: 220,
  ),
  Story(
    id: 7,
    authorName: 'Lily Thompson',
    tags: ['romance', 'comedy'],
    categoryId: 2,
    title: 'Love at First Laugh',
    description:
        'Laugh and fall in love with a delightful romantic comedy that will warm your heart.',
    coverUrl:
        'https://res.cloudinary.com/ddvdxx85g/image/upload/v1678858100/samples/animals/cat.jpg',
    isDraft: false,
    isMature: false,
    numChapter: 15,
    readCount: 600,
    voteCount: 130,
  ),
];
const List<Author> AUTHOR = [
  Author(id: 1, name: 'Pug ki lan', follower: 500),
  Author(id: 4, name: 'Pug ki lan', follower: 500),
  Author(id: 5, name: 'Pug ki lan', follower: 500),
  Author(id: 2, name: 'Long nameeeeee', follower: 500),
  Author(id: 3, name: 'i', follower: 500)
];
