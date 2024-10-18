import 'package:ebook_reader/app/data/models/book_model.dart';
import 'package:ebook_reader/app/pages/home/widgets/vocsy_epub_widget.dart';
import 'package:flutter/material.dart';

// TODO: mostrar indicador de carregamento enquanto o livro estiver sendo baixado
class BookCard extends VocsyEpubWidget {
  // constructor arguments
  final BookModel book;

  const BookCard({
    super.key,
    required this.book,
  });

  @override
  State createState() {
    return BookCardState();
  }
}

class BookCardState extends VocsyEpubWidgetState<BookCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        getBook(
          widget.book.downloadUrl,
          widget.book.id.toString(),
        );
      },
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                // book cover
                Image.network(
                  widget.book.coverUrl,
                  height: 120,
                  fit: BoxFit.scaleDown,
                ),

                // add to favorites button
                GestureDetector(
                  onTap: () {
                    print('pressed favorite ${widget.book.title}');
                  },
                  child: const Icon(Icons.bookmark_border_sharp,
                      color: Color.fromARGB(255, 255, 200, 0), size: 30),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.all(3)),

            // book title
            Text(
              widget.book.title,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            const Padding(padding: EdgeInsets.all(2)),

            // book author
            Text(
              widget.book.author,
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
