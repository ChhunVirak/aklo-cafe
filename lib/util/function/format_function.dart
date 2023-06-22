import 'package:intl/intl.dart';

String formatCurrency(num number) => NumberFormat('###.##').format(number);
