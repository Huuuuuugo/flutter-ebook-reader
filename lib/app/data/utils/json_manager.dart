import 'dart:convert';
import 'dart:io';

class JsonManager {
  static Future<Map<String, dynamic>> readFile(
    File file, {
    Map<String, dynamic>? baseJson,
  }) async {
    baseJson ??= {};

    // cria o arquivo json caso não exista
    // usa o Map 'baseJson' como json vazio
    if (!file.existsSync()) {
      await file.create();
      await saveFile(baseJson, file);
      return baseJson;
    }
    // lê o raquivo json caso exista
    else {
      String jsonString = await file.readAsString();
      return json.decode(jsonString);
    }
  }

  static Future<void> saveFile(
    Map<String, dynamic> jsonObject,
    File file,
  ) async {
    String jsonString = json.encode(jsonObject);
    await file.writeAsString(jsonString);
  }
}
