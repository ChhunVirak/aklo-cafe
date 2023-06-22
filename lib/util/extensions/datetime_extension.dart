import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get displayDateTime =>
      '${DateFormat('h:mm\a').format(this)} ${DateFormat('EEE | dd MMM yyyy', 'en').format(this)}';
}
