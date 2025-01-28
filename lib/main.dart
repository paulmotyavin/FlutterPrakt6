import 'package:flutter/material.dart';
import 'package:prakt6_flutter/film.dart';
import 'package:prakt6_flutter/theme/theme.dart';
import 'package:prakt6_flutter/theme_helper.dart';
import 'add.dart';
import 'database_helper.dart';
import 'edit.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeHelper(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeHelper>(context);

    return MaterialApp(
      title: 'Films Prakt 6',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.isDarkTheme ? secondMode : firstMode,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => const FilmsPage());
          case '/add':
            return MaterialPageRoute(builder: (context) => const AddPage());
          case '/edit':
            final film = settings.arguments as Film;
            return MaterialPageRoute(
                builder: (context) => EditPage(film: film));
          default:
            return MaterialPageRoute(builder: (context) => const FilmsPage());
        }
      },
    );
  }
}

class FilmsPage extends StatefulWidget {
  const FilmsPage({super.key});

  @override
  _FilmsPageState createState() => _FilmsPageState();
}

class _FilmsPageState extends State<FilmsPage> {

  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Film> _films = [];

  @override
  void initState() {
    super.initState();
    _loadFilms();
  }

  void _loadFilms() async {
    _films = await _databaseHelper.films();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeHelper>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Фильмы'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkTheme ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Center(
        child: _films.isNotEmpty
            ? ListView.builder(
          itemCount: _films.length,
          itemBuilder: (context, index) {
            return Container(
              key: ValueKey(_films[index].id),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                    color: Color(0xFF6C6767)
                  ),
                ],
              ),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: ListTile(
                title: Text(_films[index].title),
                subtitle: Text(_films[index].year),
                leading: Image.network(
                  _films[index].poster,
                  width: 50,
                  height: 75,
                  fit: BoxFit.contain,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      style: IconButton.styleFrom(
                          shape: const RoundedRectangleBorder(),
                      ),
                      onPressed: () async {
                        await Navigator.pushNamed(
                          context,
                          '/edit',
                          arguments: _films[index],
                        );
                        _loadFilms();
                      },
                      tooltip: 'Редактировать',
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      style: IconButton.styleFrom(
                          shape: const RoundedRectangleBorder(),
                          backgroundColor: const Color(0xFFC66767)),
                      onPressed: () async {
                        await _databaseHelper.deleteFilm(_films[index].id!);

                        _loadFilms();
                      },
                      tooltip: 'Удалить',
                    ),
                  ],
                ),
              ),
            );
          },
        )
            : const Text('Нет фильмов'),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          _loadFilms();
        },
        tooltip: 'Добавить фильм',
        child: const Icon(Icons.add),
      ),
    );
  }
}