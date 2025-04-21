import 'package:chronoreel/screens/add_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:chronoreel/types/media.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Media> searchResults = [];
  bool isLoading = false;
  Timer? _debounce;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (_searchController.text.isNotEmpty) {
        searchAniList(_searchController.text);
      } else {
        setState(() {
          searchResults = [];
        });
      }
    });
  }

  Future<void> searchAniList(String query) async {
    setState(() {
      isLoading = true;
    });

    final response = await http.post(
      Uri.parse('https://graphql.anilist.co'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'query': '''
          query (\$search: String) {
            Page(page: 1, perPage: 10) {
              media(search: \$search, type: ANIME, sort: POPULARITY_DESC) {
                id
                idMal
                title {
                  romaji
                  english
                  native
                  userPreferred
                }
                type
                format
                status
                season
                seasonYear
                seasonInt
                episodes
                duration
                chapters
                volumes
                source
                countryOfOrigin
                isLicensed
                isAdult
                description
                synonyms
                averageScore
                meanScore
                popularity
                trending
                favourites
                genres
                tags {
                  name
                  rank
                }
                coverImage {
                  large
                  medium
                  color
                }
                bannerImage
                trailer {
                  site
                  id
                }
                startDate {
                  year
                  month
                  day
                }
                endDate {
                  year
                  month
                  day
                }
                studios(isMain: true) {
                  nodes {
                    name
                  }
                }
              }
            }
          }
        ''',
        'variables': {'search': query},
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> mediaList = data['data']['Page']['media'];
      
      setState(() {
        searchResults = mediaList.map((item) {
          // Add studio information to each media item before converting
          Map<String, dynamic> mediaWithStudio = {...item};
          if (item['studios'] != null && item['studios']['nodes'] != null && 
              item['studios']['nodes'].isNotEmpty) {
            mediaWithStudio['studio'] = item['studios']['nodes'][0]['name'];
          }
          
          return Media.fromJson(mediaWithStudio);
        }).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load search results');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AniList Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search for anime...',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : searchResults.isEmpty
                    ? const Center(child: Text('Search something'))
                    : ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          final media = searchResults[index];
                          return AnimeListItem(media: media);
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class AnimeListItem extends StatelessWidget {
  final Media media;

  const AnimeListItem({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddItemScreen(anilistId: media.id.toString()),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                media.coverImage.medium,
                width: 80,
                height: 120,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${media.title.romaji} (${media.seasonYear ?? 'N/A'})',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (media.title.english != null)
                      Text(
                        media.title.english!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    const SizedBox(height: 4),
                    Text(
                      '${media.format ?? 'N/A'} • ${media.episodes ?? 'N/A'} episodes',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 4,
                      children: media.genres
                          .map(
                            (genre) => Chip(
                              label: Text(
                                genre,
                                style: const TextStyle(fontSize: 12),
                              ),
                              padding: const EdgeInsets.all(4),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 4),
                    if (media.averageScore != null)
                      Text(
                        'Score: ${media.averageScore}/100',
                        style: const TextStyle(fontSize: 14),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}