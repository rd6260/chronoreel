import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> searchResults = [];
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
                title {
                  romaji
                }
                coverImage {
                  medium
                }
                seasonYear
                format
                episodes
                studios(isMain: true) {
                  nodes {
                    name
                  }
                }
                genres
              }
            }
          }
        ''',
        'variables': {'search': query},
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        searchResults = data['data']['Page']['media'];
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
      appBar: AppBar(title: Text('AniList Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for anime...',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child:
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : searchResults.isEmpty
                    ? Center(child: Text('No results found'))
                    : ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final anime = searchResults[index];
                        return AnimeListItem(anime: anime);
                      },
                    ),
          ),
        ],
      ),
    );
  }
}

class AnimeListItem extends StatelessWidget {
  final dynamic anime;

  const AnimeListItem({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                anime['coverImage']['medium'],
                width: 80,
                height: 120,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${anime['title']['romaji']} (${anime['seasonYear'] ?? 'N/A'})',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${anime['format'] ?? 'N/A'} • ${anime['episodes'] ?? 'N/A'} episodes',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Studio: ${anime['studios']['nodes'].isNotEmpty ? anime['studios']['nodes'][0]['name'] : 'N/A'}',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Wrap(
                      spacing: 4,
                      children:
                          (anime['genres'] as List<dynamic>)
                              .map(
                                (genre) => Chip(
                                  label: Text(
                                    genre,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  padding: EdgeInsets.all(4),
                                ),
                              )
                              .toList(),
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
