## Words App

## Descrição

Um projeto incrível para demonstrar minha habilidade em desenvolvimento de aplicativos mobile com Flutter.
Usando a API [Words API](https://www.wordsapi.com/) para buscar palavras e seus significados.
Com boas práticas de programação e um código limpo e bem estruturado.
Testes unitários para garantir a qualidade do código.
Com cache de dados local para melhorar a experiência do usuário e economizando recursos de processamento.

## Features
- [x] Login com email e senha.
- [x] Verificação se ja existe um usuario logado.
- [x] Lista de palavras.
- [x] Lista de palavras favoritas.
- [x] Historico de palavras escolhidas.

## Tecnologias Utilizadas

- Linguagem: Dart
- Framework: Flutter

## Bibliotecas Utilizadas

- [localstorage](https://pub.dev/packages/localstorage)
- [http](https://pub.dev/packages/http)
- [get_it](https://pub.dev/packages/get_it)
- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [equatable](https://pub.dev/packages/equatable)
- [connectivity_plus](https://pub.dev/packages/connectivity_plus)
- [device_preview](https://pub.dev/packages/device_preview)
- [firebase_core](https://pub.dev/packages/firebase_core)
- [firebase_auth](https://pub.dev/packages/firebase_auth)
- [firebase_remote_config](https://pub.dev/packages/firebase_remote_config)
- [flutter_tts](https://pub.dev/packages/flutter_tts) 

## Instalação e Uso

1. Certifique-se de ter o Flutter instalado no seu ambiente de desenvolvimento. Caso ainda não tenha, siga as instruções em [flutter.dev](https://flutter.dev/docs/get-started/install).

2. Clone este repositório em sua máquina local:

   ```bash
   git clone https://github.com/FelipeCostaAraujo/desafio-mobile.git
   ```

3. Acesse o diretório do projeto:

   ```bash
   cd desafio-mobile/words_app
   ```

4. Instale as dependências do projeto:

   ```bash
   flutter pub get
   ```

5. Conecte um dispositivo físico ou inicie um emulador Android/iOS.

6. Inicie o aplicativo:

   ```bash
   flutter run
   ```

7. Para fazer o login no aplicativo, use seu email e senha. Caso não tenha uma conta, e criado uma conta automaticamente com o email e senha informados.    

8. Para executar os testes unitários:

   ```bash
   flutter test
   ```
     

## .gitignore

```plaintext
# Miscellaneous
*.class
*.log
*.pyc
*.swp
.DS_Store
.atom/
.buildlog/
.history
.svn/
migrate_working_dir/

# IntelliJ related
*.iml
*.ipr
*.iws
.idea/

# The .vscode folder contains launch configuration and tasks you configure in
# VS Code which you may wish to be included in version control, so this line
# is commented out by default.
#.vscode/

# Flutter/Dart/Pub related
**/doc/api/
**/ios/Flutter/.last_build_id
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub-cache/
.pub/
/build/

# Symbolication related
app.*.symbols

# Obfuscation related
app.*.map.json

# Android Studio will place build artifacts here
/android/app/debug
/android/app/profile
/android/app/release
```

## Challenge by Coodesh

Esse projeto é parte do desafio proposto pela plataforma [Coodesh](https://coodesh.com/)
