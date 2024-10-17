import 'package:ebook_reader/app/pages/home/home_page.dart';
import 'package:ebook_reader/app/pages/home/widgets/vocsy_epub_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const VocsyEpubWidget());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
