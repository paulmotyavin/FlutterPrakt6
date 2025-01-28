class Film {
  final int? id;
  final String title;
  final String poster;
  final String year;
  final String genre;
  final String director;


  Film({this.id, required this.title, required this.poster, required this.year, required this.genre, required this.director});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'poster': poster,
      'year': year,
      'genre': genre,
      'director': director
    };
  }

  @override
  String toString() {
    return 'Film{id: $id, title: $title, poster: $poster, year: $year, genre: $genre, director: $director}';
  }
}