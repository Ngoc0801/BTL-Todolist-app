import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en', ''), // Tiếng Anh
    Locale('vi', ''), // Tiếng Việt
  ];

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  // Các chuỗi văn bản cho từng ngôn ngữ
  Map<String, String> get _localizedStrings {
    switch (locale.languageCode) {
      case 'vi':
        return {
          // Common
          'app_name': 'Danh sách công việc',
          'cancel': 'Hủy',
          'delete': 'Xóa',
          'task_deleted': 'Công việc đã được xóa!',

          // TaskListScreen
          'list': 'Danh sách',

          // AddTaskScreen
          'add_new': 'Thêm mới',
          'task': 'Công việc',
          'description': 'Mô tả',
          'date': 'Ngày',
          'select_date': 'Chọn ngày',
          'add': 'Thêm',
          'fill_all_fields': 'Vui lòng điền đầy đủ các trường và chọn ngày!',

          // CalendarScreen
          'calendar': 'Lịch',
          'select_day_to_view_tasks': 'Chọn một ngày để xem công việc',
          'no_tasks_for_this_day': 'Không có công việc cho ngày này',

          // DocumentsScreen
          'documents': 'Tài liệu',
          'documents_coming_soon': 'Màn hình tài liệu - Sắp ra mắt!',

          // SettingsScreen
          'settings': 'Cài đặt',
          'dark_mode': 'Chế độ tối',
          'language': 'Ngôn ngữ',
          'clear_all_tasks': 'Xóa tất cả công việc',
          'clear_all_tasks_confirm': 'Bạn có chắc chắn muốn xóa tất cả công việc? Hành động này không thể hoàn tác.',
          'all_tasks_cleared': 'Tất cả công việc đã được xóa!',
          'app_information': 'Thông tin ứng dụng',
          'app_name_info': 'Tên ứng dụng: Danh sách công việc',
          'version': 'Phiên bản: 1.0.0',
          'developer': 'Nhà phát triển: Tên của bạn',

          // Dialogs
          'delete_task': 'Xóa công việc',
          'delete_task_confirm': 'Bạn có chắc chắn muốn xóa công việc này không?',
        };
      default: // Mặc định là tiếng Anh
        return {
          // Common
          'app_name': 'To-do List',
          'cancel': 'Cancel',
          'delete': 'Delete',
          'task_deleted': 'Task deleted!',

          // TaskListScreen
          'list': 'List',

          // AddTaskScreen
          'add_new': 'Add New',
          'task': 'Task',
          'description': 'Description',
          'date': 'Date',
          'select_date': 'Select Date',
          'add': 'Add',
          'fill_all_fields': 'Please fill in all fields and select a date!',

          // CalendarScreen
          'calendar': 'Calendar',
          'select_day_to_view_tasks': 'Select a day to view tasks',
          'no_tasks_for_this_day': 'No tasks for this day',

          // DocumentsScreen
          'documents': 'Documents',
          'documents_coming_soon': 'Documents Screen - Coming Soon!',

          // SettingsScreen
          'settings': 'Settings',
          'dark_mode': 'Dark Mode',
          'language': 'Language',
          'clear_all_tasks': 'Clear All Tasks',
          'clear_all_tasks_confirm': 'Are you sure you want to delete all tasks? This action cannot be undone.',
          'all_tasks_cleared': 'All tasks have been cleared!',
          'app_information': 'App Information',
          'app_name_info': 'App Name: To-do List',
          'version': 'Version: 1.0.0',
          'developer': 'Developer: Your Name',

          // Dialogs
          'delete_task': 'Delete Task',
          'delete_task_confirm': 'Are you sure you want to delete this task?',
        };
    }
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'vi'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}