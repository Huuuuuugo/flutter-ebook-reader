import 'package:ebook_reader/app/data/models/book_model.dart';
import 'package:ebook_reader/app/data/repositories/favorites_repository.dart';
import 'package:ebook_reader/app/pages/home/widgets/vocsy_epub_widget.dart';
import 'package:flutter/material.dart';

class BookCard extends VocsyEpubWidget {
  // constructor arguments
  final BookModel book;
  final Function? callback;

  const BookCard({
    super.key,
    this.callback,
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
    bool isFavorite = favoritesRepository!.list.contains(widget.book.id);
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
                      onTap: () async {
                        await favoritesRepository!
                            .changeFavorite(widget.book.id);
                        await favoritesRepository!.updateList();
                        setState(() {
                          isFavorite = favoritesRepository!.list
                              .contains(widget.book.id);
                        });
                        if (widget.callback != null) {
                          widget.callback!();
                        }
                      },
                      child: isFavorite
                          ? Icon(Icons.bookmark_sharp,
                              shadows: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 4.0,
                                  spreadRadius: 1.0,
                                )
                              ],
                              color: Color.fromARGB(255, 240, 0, 0),
                              size: 30)
                          : Icon(Icons.bookmark_border_sharp,
                              shadows: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(1.5, 1.0),
                                  blurRadius: 4.0,
                                  spreadRadius: 1.0,
                                )
                              ],
                              color: Color.fromARGB(255, 240, 0, 0),
                              size: 30),
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
