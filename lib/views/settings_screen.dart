import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/task_viewmodel.dart';
import '../viewmodels/theme_viewmodel.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Thay đổi theme (Light/Dark Mode)
            Consumer<ThemeViewModel>(
              builder: (context, themeViewModel, child) {
                return ListTile(
                  title: Text(
                    'Dark Mode',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  trailing: Switch(
                    value: themeViewModel.isDarkMode,
                    onChanged: (value) {
                      themeViewModel.toggleTheme();
                    },
                    activeColor: Colors.blue,
                  ),
                );
              },
            ),
            const Divider(),
            // Thay đổi ngôn ngữ
            ListTile(
              title: Text(
                'Language',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              trailing: DropdownButton<String>(
                value: _selectedLanguage,
                items: <String>['English', 'Vietnamese']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: Theme.of(context).dropdownMenuTheme.textStyle ??
                          Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLanguage = newValue!;
                    // TODO: Thêm logic để thay đổi ngôn ngữ
                  });
                },
                dropdownColor: Theme.of(context)
                    .dropdownMenuTheme
                    .menuStyle
                    ?.backgroundColor
                    ?.resolve({}) ?? Colors.grey, // Đảm bảo màu nền từ theme
                style: Theme.of(context).dropdownMenuTheme.textStyle ??
                    Theme.of(context).textTheme.bodyMedium, // Màu chữ của giá trị hiện tại
              ),
            ),
            const Divider(),
            // Xóa tất cả công việc
            Consumer<TaskViewModel>(
              builder: (context, taskViewModel, child) {
                return ListTile(
                  title: Text(
                    'Clear All Tasks',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'Clear All Tasks',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          content: Text(
                            'Are you sure you want to delete all tasks? This action cannot be undone.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                taskViewModel.clearTasks();
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'All tasks have been cleared!',
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'Delete',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Clear'),
                  ),
                );
              },
            ),
            const Divider(),
            // Thông tin ứng dụng
            ListTile(
              title: Text(
                'App Information',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'App Name: To-do List',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Version: 1.0.0',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Developer: Your Name',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}