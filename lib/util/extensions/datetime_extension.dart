import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get displayDateTime =>
      '${DateFormat('h:mm | a').format(this)}\n${DateFormat('EEE | dd MMM yyyy').format(this)}';
}
