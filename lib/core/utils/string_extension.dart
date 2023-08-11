/// Расширение типа String для возможности сделать первую букву заглавной.
extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
