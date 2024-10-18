import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class VocsyEpubWidget extends StatefulWidget {
  const VocsyEpubWidget({super.key});

  @override
  State createState() {
    return VocsyEpubWidgetState();
  }
}

// implementação de um State capaz de iniciar a leitura de um livro online com Vocsy
// basta herdar essa classe e usá-la como um State normal e quando quiser iniciar
// a leitura de um livro, basta chamar getBook() passando
// a URL e nome do EPUB que deve ser aberto
//
// TODO: implementar retomar leitura a partir da última posição salva.
class VocsyEpubWidgetState<T extends StatefulWidget> extends State<T> {
  final platform = MethodChannel('my_channel');
  bool loading = false;
  Dio dio = Dio();
  String filePath = "";

  // exemplo de uso Vocsy para leitura de um livro online
  // esse método deve ser sobrescrito pela classe que herda
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Vocsy Plugin E-pub example'),
        ),
        body: Center(
          child: loading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text('Downloading.... E-pub'),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await getBook(
                          "https://www.gutenberg.org/ebooks/63606.epub3.images",
                          'Lupe',
                        );
                      },
                      child: Text('Open Online E-pub'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  // faz o download e abertura do livro a partir de uma URL
  // este é o ponto inicial da abertura do livro, todos os outros métodos daqui
  // em diante são apenas etapas usadas na implementação deste método
  //
  // url: link de download do epub
  // fileName: nome do arquivo, sem extensão, onde o livro baixado será salvo
  getBook(String url, String fileName) async {
    print("=====filePath======$filePath");
    await _decideDownloadMethod(url, fileName);

    VocsyEpub.setConfig(
      themeColor: Theme.of(context).primaryColor,
      identifier: "iosBook",
      scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
      allowSharing: true,
      enableTts: true,
      // nightMode: true,
    );

    // get current locator
    VocsyEpub.locatorStream.listen((locator) {
      print('LOCATOR: $locator');
    });

    VocsyEpub.open(
      filePath,
    );
  }

  // verifica a versão do android para decidir a forma correta de acessar o
  // armazenamento e inicia o download do livro
  Future<void> _startDownloadAndroid(String url, String fileName) async {
    final String? version = await _getAndroidVersion();
    if (version != null) {
      String? firstPart;
      if (version.toString().contains(".")) {
        int indexOfFirstDot = version.indexOf(".");
        firstPart = version.substring(0, indexOfFirstDot);
      } else {
        firstPart = version;
      }
      int intValue = int.parse(firstPart);
      if (intValue >= 13) {
        await _startDownload(url, fileName);
      } else {
        final PermissionStatus status = await Permission.storage.request();
        if (status == PermissionStatus.granted) {
          await _startDownload(url, fileName);
        } else {
          await Permission.storage.request();
        }
      }
      print("ANDROID VERSION: $intValue");
    }
  }

  // retorna a versão do android
  Future<String?> _getAndroidVersion() async {
    try {
      final String version = await platform.invokeMethod('getAndroidVersion');
      return version;
    } on PlatformException catch (e) {
      print("FAILED TO GET ANDROID VERSION: ${e.message}");
      return null;
    }
  }

  // decide a forma correta de realizar o download a partir do OS em que a
  // aplicação está rodando
  _decideDownloadMethod(String url, String fileName) async {
    if (Platform.isIOS) {
      final PermissionStatus status = await Permission.storage.request();
      if (status == PermissionStatus.granted) {
        await _startDownload(url, fileName);
      } else {
        await Permission.storage.request();
      }
    } else if (Platform.isAndroid) {
      await _startDownloadAndroid(url, fileName);
    } else {
      PlatformException(code: '500');
    }
  }

  // faz o download do livro apenas se o arquivo de saída ainda não existir
  _startDownload(String url, String fileName) async {
    setState(() {
      loading = true;
    });
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String path = '${appDocDir!.path}/${fileName}.epub';
    print(path);
    File file = File(path);

    if (!File(path).existsSync()) {
      await file.create();
      await dio.download(
        url,
        path,
        deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {
          print('Download --- ${(receivedBytes / totalBytes) * 100}');
          setState(() {
            loading = true;
          });
        },
      ).whenComplete(() {
        setState(() {
          loading = false;
          filePath = path;
        });
      });
    } else {
      setState(() {
        loading = false;
        filePath = path;
      });
    }
  }
}
