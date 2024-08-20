# todo_app

A new Flutter project.

## Getting Started



This is the Architecture of the app

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

1. ObjectBox has been used to store data locally
2. Getit has been used for dependency injection
3. Bloc is used for state management
4. The app is based on feature first clean architecture


# Flow
Whenever the is opened for the first time 
the tasks aree fetched from remote 
thats is through the given api and stored in local db.

else 
The tasks are fetched from local db.
