import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskViewModel extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void clearTasks() {
    _tasks.clear();
    notifyListeners();
  }

  List<Task> getTasksForDay(DateTime day) {
    return _tasks.where((task) {
      return task.date.year == day.year &&
          task.date.month == day.month &&
          task.date.day == day.day;
    }).toList();
  }
}