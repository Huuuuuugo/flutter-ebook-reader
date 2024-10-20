import 'dart:convert';

import 'package:ebook_reader/app/data/http/http_client.dart';
import 'package:ebook_reader/app/data/models/book_model.dart';

abstract class IBookRepository {
  Future<List<BookModel>> getBooks();
}

class BookRepository implements IBookRepository {
  final IHttpClient client;

  BookRepository({required this.client});

  @override
  Future<List<BookModel>> getBooks() async {
    final response = await client.get(
      url: 'https://escribo.com/books.json',
    );

    if (response.statusCode == 200) {
      List<BookModel> books = [];
      List bookIds = [];

      final codeUnits = response.body.codeUnits;
      final body = jsonDecode(const Utf8Decoder().convert(codeUnits));

      body.map((item) {
        final BookModel book = BookModel.fromMap(item);
        books.add(book);
      }).toList();

      // remove ids repetidos da lista de livros
      books = books.where(
        (e) {
          if (!bookIds.contains(e.id)) {
            bookIds.add(e.id);
            return true;
          }
          return false;
        },
      ).toList();

      return books;
    } else {
      throw Exception('Unexpected status code: ${response.statusCode}');
    }
  }
}
