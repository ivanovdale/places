import 'package:places/data/dto/place_dto.dart';
import 'package:places/domain/model/coordinate_point.dart';
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

  Place.fromDto(PlaceDTO placeDTO)
      : this(
          id: placeDTO.id,
          name: placeDTO.name,
          coordinatePoint: CoordinatePoint(
            lat: placeDTO.lat,
            lon: placeDTO.lng,
          ),
          details: placeDTO.description,
          type: PlaceTypes.values.byName(placeDTO.placeType),
          photoUrlList: placeDTO.urls,
        );

  PlaceDTO toDto() => PlaceDTO(
        id: id,
        lat: coordinatePoint.lat,
        lng: coordinatePoint.lon,
        name: name,
        urls: photoUrlList ?? <String>[],
        placeType: type.toString(),
        description: details,
      );
}

/// Типы мест с названиями и иконками.
enum PlaceTypes {
  hotel(AppStrings.hotelText, AppStrings.hotel, AppAssets.hotel),
  restaurant(AppStrings.restaurantText, AppStrings.restaurant, AppAssets.restaurant),
  other(AppStrings.otherText, AppStrings.other, AppAssets.other),
  park(AppStrings.parkText, AppStrings.park, AppAssets.park),
  museum(AppStrings.museumText, AppStrings.museum, AppAssets.museum),
  monument(AppStrings.monumentText, AppStrings.monument, AppAssets.other),
  theatre(AppStrings.theatreText, AppStrings.theatre, AppAssets.other),
  temple(AppStrings.templeText, AppStrings.temple, AppAssets.other),
  cafe(AppStrings.cafeText, AppStrings.cafe, AppAssets.cafe);

  const PlaceTypes(this.text, this.name, this.imagePath);

  final String text;
  final String name;
  final String imagePath;

  @override
  String toString() => text;
}
