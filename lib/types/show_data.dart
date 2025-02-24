class ShowData {
  final String title;
  final int year;
  final String type;
  final String? image;
  final String? genre;
  final String? director;
  final String? studio;
  final List<String>? starring;
  final Map<String, dynamic> _extraData = {}; // Stores additional attributes

  ShowData({
    required this.title,
    required this.year,
    required this.type,
    this.image,
    this.genre,
    this.director,
    this.studio,
    this.starring,
  });

  // Method to add extra attributes dynamically
  void addData(String key, dynamic value) {
    _extraData[key] = value;
  }

  // Retrieve extra attributes dynamically
  dynamic getAttribute(String key) => _extraData[key];

  // Getter to print all stored data including extra attributes
  Map<String, dynamic> get data {
    return {
      'title': title,
      'year': year,
      'type': type,
      'image': image,
      'genre': genre,
      'director': director,
      'studio': studio,
      'starring': starring,
      ..._extraData, // Include additional dynamic attributes
    };
  }

  @override
  String toString() {
    return 'ShowData(title: $title, year: $year, type: $type, image: $image, genre: $genre, director: $director, studio: $studio, starring: ${starring?.join(", ")}, extraData: $_extraData)';
  }
}
