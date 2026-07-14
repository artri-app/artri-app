# Artriapp

Um app para artrite reumatoide.

## Integrantes do grupo

- José Maia de Oliveira

## Table of contents

- [Getting started](#getting-started)
- [Project architecture](#project-architecture)
- [Additional information](#additional-information)

# Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Setup the environment

This project use `.env` file for communication with APIs. Make sure your `.env` file is set before start the project and following the `.env_example` file.

## Como executar o app

1. Instale o [Flutter SDK](https://docs.flutter.dev/get-started/install) (versão compatível com o SDK `>=3.2.6 <4.0.0` definido em `pubspec.yaml`).
2. Verifique se o ambiente está corretamente configurado:
   ```bash
   flutter doctor
   ```
3. Clone o repositório e acesse a pasta do projeto:
   ```bash
   cd artri-app
   ```
4. Copie o arquivo de exemplo de variáveis de ambiente e preencha com os valores corretos:
   ```bash
   cp .env_example .env
   ```
5. Instale as dependências do projeto:
   ```bash
   flutter pub get
   ```
6. Conecte um dispositivo/emulador ou abra um navegador suportado e liste os dispositivos disponíveis:
   ```bash
   flutter devices
   ```
7. Execute o app:
   ```bash
   flutter run
   ```

# Project architecture

This project will follow the concepts of MVC architecture pattern, so the current project use this following organization:

```bash
lib/
│
├── models/                      # Data models representing the business logic entities
│   └── <model_name>.dart        # Example model
│
├── views/                       # UI screens and widgets
│   ├── widgets                  # Shared widgets with views
│   │   └── <widget>.dart
│   └── <view-name>              # View folder
│       ├── widgets              # Widgets used only on the page
│       │   └── <widget>.dart
│       └── <view-name>.dart
│
├── view_models/                 # Business logic controllers
│   └── <view_model_name>.dart
│
├── blocs/                       # Business logic components (For BLoC pattern)
│   └── <bloc_name>.dart
│
├── services/                    # Services like API or database management
│   └── <service_name>.dart      # Service for network calls
│
├── utils/                       # Utility functions and constants
│   ├── constants.dart           # Application constants
│   └── utils.dart               # Utility functions
│
├── routes/                      # Routes
│   ├── index.dart               # Export all routes
│   └── <route_name>.routes.dart # Route for each usage
│
└── main.dart                    # Entry point of the app
```

# Additional information

The bellow information is additional, but can help you to understand how flutter works and has some insights about best practices on the flutter framework.

- [The architecture of flutter](https://docs.flutter.dev/resources/architectural-overview#building-widgets)
- [Best practices of flutter](https://www.mindinventory.com/blog/flutter-development-best-practices/)
- [Widgets design](https://docs.flutter.dev/ui/widgets)

## Go Router navigation

The project use the library [GoRouter](https://pub.dev/packages/go_router) to make the navigation more easy. Below has a description about routing methods:

- `context.go()`: Will push a new page to the page stack. Use this to maintain the page stack.
- `context.go()`: Replace the page stack with the page using a new page key.
