import 'package:places/core/data/dto/location_permission_dto.dart';
import 'package:places/core/data/dto/position_dto.dart';

abstract interface class GeolocationApi {
  Future<LocationPermissionDto> requestPermission();
  Future<LocationPermissionDto> checkPermission();
  Future<PositionDto> getCurrentPosition();
}
