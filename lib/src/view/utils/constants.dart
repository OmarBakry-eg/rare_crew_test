import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

mixin Constants {
  static const List<Color> priorityColors = [
    Color(0xffFC5565),
    Color(0xffFA9B4A),
    Color(0xff58BBF7),
    Color(0xff4CCB41),
  ];
  static const String taskBoxName = 'tasks';
  static const String userBoxName = 'user';

  static final navigatorKey = GlobalKey<NavigatorState>();

  static Future<void> errorMessage(
      {String? title, String? description, Function? onPressed}) async {
    return  showDialog<void>(
      context: navigatorKey.currentContext!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? "Alert"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(description ?? 'Error Occuered'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                if (onPressed != null) {
                  onPressed();
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showLoading(
      {String? title, String? description, Function? onPressed}) async {
    return showDialog<void>(
      context: navigatorKey.currentContext!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  static void hideLoading() => navigatorKey.currentState!.pop();

  static Future<String?> selectDate(
      {DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) async {
    final DateTime? picked = await showDatePicker(
      context: navigatorKey.currentContext!,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime.now(),
      lastDate: lastDate ??
          DateTime(DateTime.now().year + 100, DateTime.now().month, DateTime.now().day),
    );
    if (picked != null) {
      return formattedDate(picked);
    }
    return null;
  }

  static String formattedDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);
}
