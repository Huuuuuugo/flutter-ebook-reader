import 'package:ebook_reader/app/data/models/book_model.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  // constructor arguments
  final BookModel book;

  const BookCard({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {print('pressed book ${book.id}')},
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                // book cover
                Image.network(
                  book.coverUrl,
                  height: 120,
                  fit: BoxFit.scaleDown,
                ),

                // add to favorites button
                GestureDetector(
                  onTap: () => {print('pressed favorite ${book.id}')},
                  child: const Icon(Icons.bookmark_border_sharp,
                      color: Color.fromARGB(255, 255, 200, 0), size: 30),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.all(3)),

            // book title
            Text(
              book.title,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            const Padding(padding: EdgeInsets.all(2)),

            // book author
            Text(
              book.author,
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
