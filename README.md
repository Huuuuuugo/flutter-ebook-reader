# Como Usar
Para usar o aplicativo basta baixar uma das versões em Releases e instalar em um celular ou emulador.

# Como Compilar
Certifique-se de que seu ambiente de desenvolvimento esteja devidamente configurado. Para compilar sua própria versão do aplicativo, siga estas etapas:

1. Instalar Dependências
Execute o seguinte comando para instalar todas as dependências necessárias:
```
flutter pub get
```
2. Compilar para Android
Para criar uma versão do aplicativo para Android que você pode instalar em um celular ou emulador, execute:
```
flutter build apk
```

3. Encontrar o APK
O APK gerado estará localizado em `build/app/outputs/flutter-apk/app-release.apk`.

# Dicas Adicionais
- **Testar Antes de Compilar**: Utilize `flutter run` para testar o aplicativo em um dispositivo conectado ou emulador antes de compilar.
- **Verificar Dependências**: Sempre atualize as dependências no `pubspec.yaml` e execute `flutter pub get` após fazer alterações.
