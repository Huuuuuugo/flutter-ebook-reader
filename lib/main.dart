import 'package:ebook_reader/app/pages/home/home_page.dart';
import 'package:ebook_reader/app/pages/home/widgets/book_widget.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFavoritesRepository(); // instancia o FavoritesRepository do BookCard

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 4.0,
          shadowColor: Theme.of(context).colorScheme.shadow,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      ),
      home: HomePage(),
    );
  }
}
