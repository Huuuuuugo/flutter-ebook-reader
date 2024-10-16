// import 'package:ebook_reader/example.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello, world!', textDirection: TextDirection.ltr),
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
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  // constructor arguments
  final String title;
  final String author;
  final String cover;

  const BookCard(
      {super.key,
      required this.title,
      required this.author,
      required this.cover});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {print('pressed book')},
      child: SizedBox(
        width: 110,
        height: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                // book cover
                Image.network(
                  cover,
                ),

                // add to favorites button
                GestureDetector(
                  onTap: () => {print('pressed favorite')},
                  child: const Icon(Icons.bookmark_border_sharp,
                      color: Color.fromARGB(255, 255, 200, 0), size: 30),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.all(3)),

            // book title
            Text(
              title,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            const Padding(padding: EdgeInsets.all(2)),

            // book author
            Text(
              author,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
