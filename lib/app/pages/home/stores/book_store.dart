import 'package:ebook_reader/app/data/models/book_model.dart';
import 'package:ebook_reader/app/data/repositories/book_repository.dart';
import 'package:flutter/material.dart';

class BookStore {
  final IBookRepository repository;

  BookStore({required this.repository});

  // loading state
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // result state
  final ValueNotifier<List<BookModel>> result =
      ValueNotifier<List<BookModel>>([]);

  // error state
  final ValueNotifier<String> error = ValueNotifier<String>('');

  getBooks() async {
    isLoading.value = true;

    try {
      final repositoryResult = await repository.getBooks();
      result.value = repositoryResult;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}
