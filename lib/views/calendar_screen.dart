import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../viewmodels/task_viewmodel.dart';
import '../l10n/app_localizations.dart';
import 'package:intl/intl.dart'; // Thêm để định dạng ngày tháng theo ngôn ngữ

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Future<void> _selectMonthYear(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _focusedDay,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (picked != null) {
      setState(() {
        _focusedDay = DateTime(picked.year, picked.month, 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.translate('calendar'),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month, color: Colors.blue),
            onPressed: () => _selectMonthYear(context),
          ),
        ],
      ),
      body: Consumer<TaskViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                locale: l10n.locale.languageCode, // Đặt ngôn ngữ cho lịch
                headerStyle: HeaderStyle(
                  titleTextFormatter: (date, locale) {
                    // Tùy chỉnh tiêu đề tháng và năm
                    return DateFormat.yMMMM(locale).format(date);
                  },
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                calendarBuilders: CalendarBuilders(
                  dowBuilder: (context, day) {
                    // Tùy chỉnh nhãn ngày trong tuần (Mon, Tue, ...)
                    final text = DateFormat.E(l10n.locale.languageCode).format(day);
                    return Center(
                      child: Text(
                        text,
                        style: const TextStyle(color: Colors.blue),
                      ),
                    );
                  },
                  markerBuilder: (context, date, events) {
                    final tasks = viewModel.getTasksForDay(date);
                    if (tasks.isNotEmpty) {
                      return Positioned(
                        right: 1,
                        bottom: 1,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                      );
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _selectedDay != null
                    ? _buildTaskList(viewModel, _selectedDay!)
                    : Center(
                        child: Text(
                          l10n.translate('select_day_to_view_tasks'),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTaskList(TaskViewModel viewModel, DateTime selectedDay) {
    final l10n = AppLocalizations.of(context);
    final tasks = viewModel.getTasksForDay(selectedDay);
    if (tasks.isEmpty) {
      return Center(
        child: Text(
          l10n.translate('no_tasks_for_this_day'),
          style: const TextStyle(fontSize: 16),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
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
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(l10n.translate('delete_task')),
                        content: Text(l10n.translate('delete_task_confirm')),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(l10n.translate('cancel')),
                          ),
                          TextButton(
                            onPressed: () {
                              viewModel.deleteTask(task.id);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(l10n.translate('task_deleted'))),
                              );
                            },
                            child: Text(
                              l10n.translate('delete'),
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}