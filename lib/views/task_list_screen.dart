import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../viewmodels/task_viewmodel.dart';
import 'add_task_screen.dart';
import 'calendar_screen.dart';
import 'documents_screen.dart';
import 'settings_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const TaskListScreenContent(),
    const CalendarScreen(),
    const DocumentsScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddTaskScreen()),
                );
              },
              backgroundColor: Colors.blue,
              shape: const CircleBorder(),
              elevation: 10,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 32,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color ?? Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey[400],
          onTap: _onItemTapped,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
    );
  }
}

class TaskListScreenContent extends StatelessWidget {
  const TaskListScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(
            'assets/uth_logo.png',
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          ),
        ),
        title: const Text(
          'List',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Consumer<TaskViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: viewModel.tasks.length,
            itemBuilder: (context, index) {
              final task = viewModel.tasks[index];
              return TaskItem(task: task);
            },
          );
        },
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    switch (task.id % 3) {
      case 0:
        backgroundColor = const Color(0xFFBBDEFB);
        break;
      case 1:
        backgroundColor = const Color(0xFFF8BBD0);
        break;
      default:
        backgroundColor = const Color(0xFFC8E6C9);
    }

    return Card(
      color: backgroundColor,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              task.description,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}