import 'package:geolocator/geolocator.dart';
import 'package:places/core/data/dto/location_permission_dto.dart';
import 'package:places/core/data/dto/position_dto.dart';
import 'package:places/core/domain/source/geolocation/geolocation_api.dart';

final class GeolocationApiImpl implements GeolocationApi {
  @override
  Future<LocationPermissionDto> checkPermission() =>
      Geolocator.checkPermission();

  @override
  Future<PositionDto> getCurrentPosition() => Geolocator.getCurrentPosition();

  @override
  Future<LocationPermissionDto> requestPermission() =>
      Geolocator.requestPermission();
}
