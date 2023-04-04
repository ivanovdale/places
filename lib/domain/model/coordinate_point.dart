import 'dart:math';

/// Географические координаты точки.
///
/// Свойства:
/// * [lat] - географические долгота точки;
/// * [lon] - географическая широта точки.
class CoordinatePoint {
  final double lat;
  final double lon;

  CoordinatePoint({
    required this.lat,
    required this.lon,
  });

  /// Возвращает признак, находится ли точка внутри окружности
  /// с нижней границей [radiusFrom] и верхней [radiusTo]. Центр окружности [centerPoint].
  bool isPointInsideRadius(
    CoordinatePoint centerPoint,
    double radiusFrom,
    double radiusTo,
  ) {
    const ky = 40000 / 360;
    final kx = cos(pi * centerPoint.lat / 180.0) * ky;
    final dx = (centerPoint.lon - lon).abs() * kx;
    final dy = (centerPoint.lat - lat).abs() * ky;

    final calculatedDistance = sqrt(dx * dx + dy * dy);

    return calculatedDistance >= radiusFrom && calculatedDistance <= radiusTo;
  }
}
