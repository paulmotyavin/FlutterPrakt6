import 'package:flutter/material.dart';
import 'package:prakt6_flutter/theme_helper.dart';
import 'package:provider/provider.dart';
import 'database_helper.dart';
import 'film.dart';

class EditPage extends StatefulWidget {
  final Film film;

  const EditPage({required this.film});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late String title;
  late String poster;
  late String year;
  late String genre;
  late String director;

  @override
  void initState() {
    super.initState();
    title = widget.film.title;
    poster = widget.film.poster;
    year = widget.film.year;
    genre = widget.film.genre;
    director = widget.film.director;
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseHelper databaseHelper = DatabaseHelper();
    final themeProvider = Provider.of<ThemeHelper>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Вернуться',
        ),
        title: Text("Изменение фильма"),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkTheme
                ? Icons.wb_sunny
                : Icons.nightlight_round),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Вы можете изменить фильм",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 200,
            child: TextField(
                onChanged: (titleValue) {
                  title = titleValue;
                },
                controller: TextEditingController(text: title),
                decoration: InputDecoration(
                  hintText: "Название",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF9067C6))),
                )),
          ),
          SizedBox(
            width: 200,
            child: TextField(
                onChanged: (posterValue) {
                  poster = posterValue;
                },
                controller: TextEditingController(text: poster),
                decoration: InputDecoration(
                  hintText: "Постер URL",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF9067C6))),
                )),
          ),
          SizedBox(
            width: 200,
            child: TextField(
                onChanged: (yearValue) {
                  year = yearValue;
                },
                controller: TextEditingController(text: year),
                decoration: InputDecoration(
                  hintText: "Год выхода",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF9067C6))),
                )),
          ),
          SizedBox(
            width: 200,
            child: TextField(
                onChanged: (genreValue) {
                  genre = genreValue;
                },
                controller: TextEditingController(text: genre),
                decoration: InputDecoration(
                  hintText: "Жанр",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF9067C6))),
                )),
          ),
          SizedBox(
            width: 200,
            child: TextField(
                onChanged: (directorValue) {
                  director = directorValue;
                },
                controller: TextEditingController(text: director),
                decoration: InputDecoration(
                  hintText: "Режиссер",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF9067C6))),
                )),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: SizedBox(
              width: 85,
              height: 45,
              child: FloatingActionButton(
                onPressed: () {
                  if (title.isEmpty || poster.isEmpty || year.isEmpty || genre.isEmpty || director.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Пожалуйста, заполните все поля.')),
                    );
                    return;
                  }

                  Film film = Film(id:widget.film.id,title: title, poster: poster, year: year, genre: genre, director: director);
                  databaseHelper.updateFilm(film);
                  Navigator.pop(context);
                },
                child: Text("Сохранить"),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
