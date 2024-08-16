# todo_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



lib/
├── core/
│   └── usecases/
│       └── usecase.dart
├── data/
│   ├── datasources/
│   │   ├── task_local_data_source.dart
│   │   └── task_remote_data_source.dart
│   ├── models/
│   │   └── task_model.dart
│   ├── repositories/
│       └── task_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── task.dart
│   ├── repositories/
│   │   └── task_repository.dart
│   └── usecases/
│       └── get_tasks.dart
├── injection_container.dart
├── presentation/
│   ├── blocs/
│   │   └── task_bloc.dart
│   ├── pages/
│   │   ├── task_list_screen.dart
│   │   └── task_form_screen.dart
│   └── widgets/
│       └── task_item.dart
└── main.dart
