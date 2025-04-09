import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/database_helper.dart';

class TaskViewModel extends ChangeNotifier {
  List<Task> _tasks = [];
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  List<Task> get tasks => _tasks;

  TaskViewModel() {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    _tasks = await _dbHelper.getAllTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    final newTask = await _dbHelper.insertTask(task);
    _tasks.add(newTask);
    notifyListeners();
  }

  Future<void> clearTasks() async {
    await _dbHelper.deleteAllTasks();
    _tasks.clear();
    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    await _dbHelper.deleteTask(id);
    _tasks.removeWhere((task) => task.id == id);
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