import 'package:places/domain/coordinate_point.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_strings.dart';

/// Модель достопримечательности.
///
/// Имеет следующие поля:
/// * [id] - идентификатор;
/// * [name] - название достопримечательности;
/// * [coordinatePoint] - географические координаты точки;
/// * [photoUrlList] - пути до фотографии в интернете;
/// * [details] - подробное описание места;
/// * [type] - тип достопримечательности;
/// * [workTimeFrom] - время работы "с". Например, 09:00;
/// * [visitDate] - запланированная дата посещения. Например, 12 окт. 2022;
/// * [visited] - признак посещения.
class Sight {
  int id;
  String name;
  CoordinatePoint coordinatePoint;
  List<String>? photoUrlList;
  String details;
  SightTypes type;
  String? workTimeFrom;
  String? visitDate;
  bool visited;

  Sight({
    required this.id,
    required this.name,
    required this.coordinatePoint,
    required this.details,
    required this.type,
    this.workTimeFrom,
    this.visitDate,
    this.visited = false,
    this.photoUrlList,
  });
}

enum SightTypes {
  hotel(AppStrings.hotel, AppAssets.hotel),
  restaurant(AppStrings.restaurant, AppAssets.restaurant),
  particularPlace(AppStrings.particularPlace, AppAssets.particularPlace),
  park(AppStrings.park, AppAssets.park),
  museum(AppStrings.museum, AppAssets.museum),
  coffeeShop(AppStrings.coffeeShop, AppAssets.coffeeShop);

  const SightTypes(this.name, this.imagePath);

  final String name;
  final String imagePath;

  @override
  String toString() => name;
}
