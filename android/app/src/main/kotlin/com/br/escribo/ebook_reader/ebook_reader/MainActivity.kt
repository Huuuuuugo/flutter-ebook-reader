package com.br.escribo.ebook_reader.ebook_reader

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.Build

// o exemplo de uso do Vocsy Epub Viewer disponibilizado pelos desenvolvedores faz uso do método "getAndroidVersion" 
// para obter a versão do android do dispositivo e decidir a forma apropriada de acessar o armazenamento. Essa classe 
// implementa esse método para que o exemplo possa ser propriamente usado no aplicativo.
class MainActivity: FlutterActivity() {
    private val CHANNEL = "my_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getAndroidVersion" -> {
                    result.success(Build.VERSION.RELEASE) // Send the Android version back
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
