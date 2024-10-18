import 'package:ebook_reader/app/data/models/book_model.dart';
import 'package:ebook_reader/app/data/repositories/favorites_repository.dart';
import 'package:ebook_reader/app/pages/home/widgets/vocsy_epub_widget.dart';
import 'package:flutter/material.dart';

// TODO: iniciar ícone de favorito de acordo com a lista de favoritos
// TODO: atualizar ícone de favorito quando tocado
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
              alignment: AlignmentDirectional.center,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    loading
                        ? Column(
                            children: [
                              ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Colors.grey,
                                  BlendMode.saturation,
                                ),
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Colors.grey,
                                    BlendMode.darken,
                                  ),
                                  child: Image.network(
                                    widget.book.coverUrl,
                                    height: 120,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Image.network(
                            widget.book.coverUrl,
                            height: 120,
                            fit: BoxFit.scaleDown,
                          ),

                    // add to favorites button
                    GestureDetector(
                      onTap: () {
                        favoritesRepository?.changeFavorite(widget.book.id);
                      },
                      child: const Icon(Icons.bookmark_border_sharp,
                          color: Color.fromARGB(255, 255, 200, 0), size: 30),
                    ),
                  ],
                ),
                if (loading)
                  Column(children: [
                    CircularProgressIndicator(),
                    const Padding(padding: EdgeInsets.all(3)),
                    Text(
                      '  ${progress.toStringAsFixed(2)}%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ])
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
