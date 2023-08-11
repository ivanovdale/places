import 'package:intl/intl.dart';

/// Форматирует дату для списков посещённых/планируемых к посещению мест.
class VisitingDateFormatter {
  static String getFormattedString(String text, DateTime? dateTime) {
    var formattedString = '';
    if (dateTime != null) {
      final dateString = _formatDate(dateTime);
      formattedString = '$text $dateString';
    }

    return formattedString;
  }

  static String _formatDate(DateTime dateTime) {
    final dateFormatter = DateFormat('d MMM yyyy hh:mm', 'ru');
    final dateFormatted = dateFormatter.format(dateTime);

    return dateFormatted;
  }
}
