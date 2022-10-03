/// Географические координаты точки.
///
/// Свойства:
/// * [lat] - географические долгота точки;
/// * [lon] - географическая широта точки;
class CoordinatePoint {
  final double lat;
  final double lon;

  CoordinatePoint({
    required this.lat,
    required this.lon,
  });
}
