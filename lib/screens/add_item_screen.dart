import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddItemScreen extends StatefulWidget {
  final String anilistId;

  const AddItemScreen({super.key, required this.anilistId});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  Map<String, dynamic>? animeData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMediaData();
  }

  Future<void> fetchMediaData() async {
    const String url = 'https://graphql.anilist.co';
    final query = '''
      query (\$id: Int) {
        Media(id: \$id, type: ANIME) {
          id
          title {
            romaji
            english
          }
          description
          coverImage {
            large
            extraLarge
          }
          bannerImage
          genres
          characters(sort: ROLE, role: MAIN) {
            edges {
              node {
                name {
                  full
                }
              }
              voiceActors(language: JAPANESE) {
                name {
                  full
                }
              }
            }
          }
        }
      }
    ''';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'query': query,
          'variables': {'id': int.parse(widget.anilistId)},
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          animeData = data['data']['Media'];
          isLoading = false;
        });
      } else {
        print('Error: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _showLibrarySelectionDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Library'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Watching'),
                onTap: () {
                  // Add to watching library
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Plan to Watch'),
                onTap: () {
                  // Add to plan to watch library
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Completed'),
                onTap: () {
                  // Add to completed library
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                animeData?['bannerImage'] ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: Colors.grey[300]);
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Poster
                      Hero(
                        tag: 'anime_poster_${widget.anilistId}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            animeData?['coverImage']['large'] ?? '',
                            height: 200,
                            width: 140,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 200,
                                width: 140,
                                color: Colors.grey[300],
                                child: const Icon(Icons.image_not_supported),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Titles and info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              animeData?['title']['romaji'] ?? '',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            if (animeData?['title']['english'] != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                animeData!['title']['english'],
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(color: Colors.grey[600]),
                              ),
                            ],
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 4,
                              runSpacing: 4,
                              children:
                                  (animeData?['genres'] as List<dynamic>?)
                                      ?.map(
                                        (genre) => Chip(
                                          label: Text(
                                            genre.toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          padding: const EdgeInsets.all(4),
                                        ),
                                      )
                                      .toList() ??
                                  [],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Voice Actors
                  if ((animeData?['characters']['edges'] as List<dynamic>?)
                          ?.isNotEmpty ??
                      false) ...[
                    Text(
                      'Starring',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          (animeData?['characters']['edges'] as List<dynamic>?)
                              ?.map((edge) {
                                final character = edge['node']['name']['full'];
                                final voiceActor =
                                    edge['voiceActors']?[0]?['name']?['full'] ??
                                    'N/A';
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text('$character (CV: $voiceActor)'),
                                );
                              })
                              .toList() ??
                          [],
                    ),
                    const SizedBox(height: 16),
                  ],
                  // Description
                  if (animeData?['description'] != null) ...[
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      animeData!['description'],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                  ],
                  // Add Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _showLibrarySelectionDialog,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Add to Library',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
