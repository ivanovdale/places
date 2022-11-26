import 'package:places/data/model/coordinate_point.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_strings.dart';

/// Модель места.
///
/// Имеет следующие поля:
/// * [id] - идентификатор;
/// * [name] - название места;
/// * [coordinatePoint] - географические координаты точки;
/// * [photoUrlList] - пути до фотографии в интернете;
/// * [details] - подробное описание места;
/// * [type] - тип места;
/// * [workTimeFrom] - время работы "с". Например, 09:00;
/// * [visitDate] - запланированная дата посещения. Например, 12 окт. 2022;
/// * [visited] - признак посещения.
class Place {
  int id;
  String name;
  CoordinatePoint coordinatePoint;
  List<String>? photoUrlList;
  String details;
  PlaceTypes type;
  String? workTimeFrom;
  DateTime? visitDate;
  bool visited;

  Place({
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

enum PlaceTypes {
  hotel(AppStrings.hotel, AppAssets.hotel),
  restaurant(AppStrings.restaurant, AppAssets.restaurant),
  particularPlace(AppStrings.particularPlace, AppAssets.particularPlace),
  park(AppStrings.park, AppAssets.park),
  museum(AppStrings.museum, AppAssets.museum),
  coffeeShop(AppStrings.coffeeShop, AppAssets.coffeeShop);

  const PlaceTypes(this.name, this.imagePath);

  final String name;
  final String imagePath;

  @override
  String toString() => name;
}
