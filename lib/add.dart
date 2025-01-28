import 'package:flutter/material.dart';
import 'package:prakt6_flutter/add.dart';
import 'package:prakt6_flutter/theme_helper.dart';
import 'package:provider/provider.dart';

import 'database_helper.dart';
import 'film.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String title = "";
  String poster = "";
  String year = "";
  String genre = "";
  String director = "";

  @override
  Widget build(BuildContext context) {
    final DatabaseHelper databaseHelper = DatabaseHelper();
    final themeProvider = Provider.of<ThemeHelper>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamed(context, '/'),
          tooltip: 'Вернуться',
        ),
        title: const Text("Добавление фильма"),
        shape: const RoundedRectangleBorder(
            side: BorderSide(
                strokeAlign: BorderSide.strokeAlignOutside,
                color: Color(0xFF242038)),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
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
          const Text(
            "Заполните данные для фильма",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 200,
            child: TextField(
                style: const TextStyle(color: Color(0xFF242038)),
                onChanged: (title1) {
                  title = title1;
                },
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
                style: const TextStyle(color: Color(0xFF242038)),
                onChanged: (poster1) {
                  poster = poster1;
                },
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
                style: const TextStyle(color: Color(0xFF242038)),
                onChanged: (year1) {
                  year = year1;
                },
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
                style: const TextStyle(color: Color(0xFF242038)),
                onChanged: (genre1) {
                  genre = genre1;
                },
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
                style: const TextStyle(color: Color(0xFF242038)),
                onChanged: (director1) {
                  director = director1;
                },
                decoration: InputDecoration(
                  hintText: "Режиссер",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF9067C6))),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              width: 85,
              height: 45,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Color(0xFF242038)),
                    borderRadius: BorderRadius.circular(15)),
                onPressed: () {
                  if (title.isEmpty ||
                      poster.isEmpty ||
                      year.isEmpty ||
                      genre.isEmpty ||
                      director.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Пожалуйста, заполните все поля.')),
                    );
                    return;
                  }

                  Film film = Film(
                      title: title,
                      poster: poster,
                      year: year,
                      genre: genre,
                      director: director);
                  databaseHelper.insertFilm(film);
                  Navigator.pop(context);
                },
                child: const Text(
                  "Добавить",
                  style: TextStyle(color: Color(0xFF242038)),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
