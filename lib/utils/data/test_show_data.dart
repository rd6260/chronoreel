import 'package:chronoreel/types/show_data.dart';

// final List<Map<String, dynamic>> shows = [
//   {
//     'title': 'PIGPEN',
//     'year': '2019',
//     'image': 'https://cdn.myanimelist.net/images/manga/2/260276.jpg',
//     'genre': 'Drama, Horror, Mystery, Thriller',
//     'author': 'Carnby Kim, Youngchan Hwang',
//     'starring': 'Jin-Hyeok Song, Minu',
//   },
//   {
//     'title': 'NIER: AUTOMATA',
//     'year': '2023',
//     'image': 'https://cdn.myanimelist.net/images/anime/1399/128318.jpg',
//     'genre': 'ACTION, FANTASY, SCI-FI',
//     'producer': 'ANIPLEX',
//     'director': 'RYOUJI MASUYAMA',
//     'studio': 'A-1 PICTURES',
//     'starring': 'YUI ISHIKAWA, AYAKA SUWA, NATSUKI HANAE',
//   },
//   {
//     'title': 'Perfect Blue',
//     'year': '1997',
//     'Type': 'Anime Movie',
//     'image': 'https://cdn.myanimelist.net/images/anime/1254/134212.jpg',
//     'genre': 'Avant Garde, Award Winning, Drama, Horror, Suspense',
//     'producer': 'Madhouse',
//     'director': 'RYOUJI MASUYAMA',
//     'studio': 'A-1 PICTURES',
//     'starring': 'YUI ISHIKAWA, AYAKA SUWA, NATSUKI HANAE',
//   },
// ];

final List<ShowData> shows = [
  ShowData(
    title: "Pigpen",
    year: 2019,
    type: 'Anime',
    image: 'https://cdn.myanimelist.net/images/manga/2/260276.jpg',
    genre: 'Drama, Horror, Mystery, Thriller',
    starring: ['Jin-Hyeok Song', 'Minu'],
  ),
  ShowData(
    title: 'NIER: AUTOMATA',
    year: 2023,
    type: 'Anime',
    image: 'https://cdn.myanimelist.net/images/anime/1399/128318.jpg',
    genre: 'ACTION, FANTASY, SCI-FI',
    // producer: 'ANIPLEX',
    director: 'RYOUJI MASUYAMA',
    studio: 'A-1 PICTURES',
    starring: ['YUI ISHIKAWA', 'AYAKA SUWA', 'NATSUKI HANAE'],
  ),
  ShowData(
    title: 'Perfect Blue',
    year: 1997,
    type: 'Anime Movie',
    image: 'https://cdn.myanimelist.net/images/anime/1254/134212.jpg',
    genre: 'Avant Garde, Award Winning, Drama, Horror, Suspense',
    studio: 'Madhouse',
    director: 'RYOUJI MASUYAMA',
    starring: ['YUI ISHIKAWA', 'AYAKA SUWA', 'NATSUKI HANAE']
    
  )
];
