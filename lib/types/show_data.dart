class ShowData {
  final String title;
  final int year;
  final String type;
  final String? image;
  final String? genre;
  final String? director;
  final String? studio;
  final List<String>? starring;

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

  @override
  String toString() {
    return 'ShowData(title: $title, year: $year, image: $image, genre: $genre, director: $director, studio: $studio, starring: ${starring?.join(", ")})';
  }
}
