import 'package:intl/intl.dart';

String dateFormatter(DateTime date) {
  return DateFormat('EE, MMM dd').format(date);
}
