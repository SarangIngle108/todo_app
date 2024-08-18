import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int id;
  final String title;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  @override
  List<Object?> get props => [
        id,
        title,
      ];
}
