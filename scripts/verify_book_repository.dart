import 'dart:io';

import 'package:ebook_reader/app/data/http/http_client.dart';
import 'package:ebook_reader/app/data/repositories/book_repository.dart';

void main(List<String> args) async {
  final client = HttpClient();
  final books = BookRepository(client: client);

  var booksList = await books.getBooks();

  // sleep(const Duration(seconds: 3));
  for (var book in booksList) {
    print(book.id);
    print(book.title);
    print(book.author);
    print(book.coverUrl);
    print(book.downloadUrl);
  }

  exit(0);
}
