import 'package:ebook_reader/app/data/http/http_client.dart';
import 'package:ebook_reader/app/data/repositories/book_repository.dart';
import 'package:ebook_reader/app/pages/home/stores/book_store.dart';
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
  final store = BookStore(
    repository: BookRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Leitor de ebook',
          textDirection: TextDirection.ltr,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: AnimatedBuilder(
                animation: Listenable.merge([
                  store.isLoading,
                  store.result,
                  store.error,
                ]),
                builder: (context, child) {
                  // exibe indicador de carregamento
                  if (store.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  // exibe erro ao requisitar arquivo
                  if (store.error.value.isNotEmpty) {
                    Center(
                      child: Text(
                        store.error.value,
                        textDirection: TextDirection.ltr,
                      ),
                    );
                  }

                  // exibe aviso de lista vazia
                  if (store.result.value.isEmpty) {
                    const Center(
                      child: Text(
                        'Lista de livros vazia',
                        textDirection: TextDirection.ltr,
                      ),
                    );
                  }

                  // exibe a grade de cards do livro
                  return GridView.builder(
                    itemCount: store.result.value.length,
                    padding: const EdgeInsets.only(top: 64, bottom: 80),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (_, index) {
                      final item = store.result.value[index];

                      return BookCard(
                        book: item,
                      );
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
