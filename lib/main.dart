import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Thêm import
import 'viewmodels/task_viewmodel.dart';
import 'viewmodels/theme_viewmodel.dart';
import 'views/task_list_screen.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en', ''); // Giá trị mặc định

  @override
  void initState() {
    super.initState();
    _loadLocale(); // Tải ngôn ngữ đã lưu khi khởi động
  }

  // Tải ngôn ngữ từ SharedPreferences
  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('languageCode') ?? 'en'; // Mặc định là 'en'
    setState(() {
      _locale = Locale(languageCode, '');
    });
  }

  // Lưu ngôn ngữ vào SharedPreferences
  Future<void> _saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
  }

  void setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
    _saveLocale(newLocale); // Lưu ngôn ngữ mới
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskViewModel()),
        ChangeNotifierProvider(create: (context) => ThemeViewModel()),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (context, themeViewModel, child) {
          return MaterialApp(
            title: 'To-do List',
            locale: _locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: themeViewModel.themeData,
            home: TaskListScreen(onLocaleChange: setLocale),
          );
        },
      ),
    );
  }
}