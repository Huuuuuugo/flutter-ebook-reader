import 'dart:io';

import 'package:ebook_reader/app/data/utils/json_manager.dart';
import 'package:path_provider/path_provider.dart';

class FavoritesRepository {
  late String favoritesPath;
  late File file;
  Map<String, dynamic> baseFavoritesFile = {
    'favorites': [],
  };

  FavoritesRepository._create() {
    print('iniciado construtor privado');
  }

  static Future<FavoritesRepository> create() async {
    var instance = FavoritesRepository._create();

    await instance._getAttributes();

    return instance;
  }

  _getAttributes() async {
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    favoritesPath = '${appDocDir!.path}/favorites.json';
    file = File(favoritesPath);
  }

  changeFavorite(int bookId) async {
    Map<String, dynamic> favoritesJson =
        await JsonManager.readFile(file, baseJson: baseFavoritesFile);
    List favoritesList = favoritesJson['favorites'];

    if (!favoritesList.contains(bookId)) {
      favoritesList.add(bookId);
    } else {
      favoritesList.remove(bookId);
    }

    favoritesJson['favorites'] = favoritesList;
    await JsonManager.saveFile(favoritesJson, file);

    print(favoritesJson);
  }
}
