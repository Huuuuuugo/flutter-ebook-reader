import 'package:ebook_reader/app/data/http/http_client.dart';
import 'package:ebook_reader/app/data/repositories/book_repository.dart';
import 'package:ebook_reader/app/data/repositories/favorites_repository.dart';
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
  bool favoritesToggle = false;

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
          Row(
            children: [
              Padding(padding: const EdgeInsets.only(top: 32, left: 16)),
              Text(
                'Apenas favoritos: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Transform.scale(
                scale: 0.7,
                child: Switch(
                    value: favoritesToggle,
                    onChanged: (bool newValue) {
                      setState(() {
                        favoritesToggle = newValue;
                      });
                    }),
              ),
            ],
          ),
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

                  // define a lista de livros que serão exibidos
                  favoritesRepository!.updateList();
                  List booksList = store.result.value;

                  if (favoritesToggle) {
                    List favoritesList = favoritesRepository!.list;
                    booksList = booksList
                        .where((e) => favoritesList.contains(e.id))
                        .toList();
                  }

                  // exibe aviso de lista vazia
                  if (booksList.isEmpty) {
                    return const Center(
                      child: Text(
                        'Lista de livros vazia.',
                        textDirection: TextDirection.ltr,
                      ),
                    );
                  }
                  print(favoritesRepository!.list);

                  // exibe a grade de cards do livro
                  return GridView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: booksList.length,
                    padding: const EdgeInsets.only(top: 48, bottom: 80),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (_, index) {
                      final item = booksList[index];

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
