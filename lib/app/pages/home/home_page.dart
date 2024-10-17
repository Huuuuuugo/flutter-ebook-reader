import 'package:ebook_reader/app/pages/home/widgets/book_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.blue,
        title: const Text(
          'Leitor de ebook',
          textDirection: TextDirection.ltr,
        ),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BookCard(
                  title: 'The Bible of Nature',
                  author: 'Oswald, Felix L.',
                  cover:
                      'https://www.gutenberg.org/cache/epub/72134/pg72134.cover.medium.jpg'),
              BookCard(
                  title: 'Kazan',
                  author: 'Curwood, James Oliver',
                  cover:
                      'https://www.gutenberg.org/cache/epub/72127/pg72127.cover.medium.jpg')
            ],
          )
        ],
      ),
    );
  }
}
