import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/task_viewmodel.dart';
import '../viewmodels/theme_viewmodel.dart';
import '../l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const SettingsScreen({super.key, required this.onLocaleChange});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String _selectedLanguage;
  bool _isInitialized = false; // Biến để kiểm soát việc khởi tạo

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      // Đồng bộ _selectedLanguage với ngôn ngữ hiện tại
      final currentLocale = AppLocalizations.of(context).locale;
      _selectedLanguage = currentLocale.languageCode == 'vi' ? 'Vietnamese' : 'English';
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.translate('settings'),
          style: const TextStyle(
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
                    l10n.translate('dark_mode'),
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
                l10n.translate('language'),
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
                    widget.onLocaleChange(
                      newValue == 'English'
                          ? const Locale('en', '')
                          : const Locale('vi', ''),
                    );
                  });
                },
                dropdownColor: Theme.of(context)
                    .dropdownMenuTheme
                    .menuStyle
                    ?.backgroundColor
                    ?.resolve({}) ?? Colors.grey,
                style: Theme.of(context).dropdownMenuTheme.textStyle ??
                    Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const Divider(),
            // Xóa tất cả công việc
            Consumer<TaskViewModel>(
              builder: (context, taskViewModel, child) {
                return ListTile(
                  title: Text(
                    l10n.translate('clear_all_tasks'),
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
                            l10n.translate('clear_all_tasks'),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          content: Text(
                            l10n.translate('clear_all_tasks_confirm'),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                l10n.translate('cancel'),
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
                                      l10n.translate('all_tasks_cleared'),
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                l10n.translate('delete'),
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
                    child: Text(l10n.translate('delete')),
                  ),
                );
              },
            ),
            const Divider(),
            // Thông tin ứng dụng
            ListTile(
              title: Text(
                l10n.translate('app_information'),
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
                    l10n.translate('app_name_info'),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    l10n.translate('version'),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    l10n.translate('developer'),
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