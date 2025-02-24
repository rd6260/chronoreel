import 'package:flutter/material.dart';

class ShowCard extends StatelessWidget {
  final Map<String, dynamic> show;

  const ShowCard({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFD1C6C9), // Light cream background
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Poster Image - Fixed height
          AspectRatio(
            aspectRatio: 4 / 5, // Square image
            child: Image.network(
              show['image'],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          // Info Section - Scrollable
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Year
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            show['title'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              height: 1,
                            ),
                          ),
                        ),
                        Text(
                          show['year'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Genre
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Genre    ',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          TextSpan(
                            text: show['genre'],
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Credits (Author/Producer/Director)
                    if (show['author'] != null)
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Author/Artist    ',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            TextSpan(
                              text: show['author'],
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (show['producer'] != null)
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Produced by    ',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            TextSpan(
                              text: show['producer'],
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (show['director'] != null)
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Directed by    ',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            TextSpan(
                              text: show['director'],
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (show['studio'] != null)
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Studios    ',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            TextSpan(
                              text: show['studio'],
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Starring
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Starring    ',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          TextSpan(
                            text: show['starring'],
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
