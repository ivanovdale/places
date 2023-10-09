import 'package:geolocator/geolocator.dart';

typedef LocationPermissionDto = LocationPermission;

extension LocationPermissionDtoExt on LocationPermissionDto {
  bool get isAllowed =>
      this == LocationPermissionDto.always ||
      this == LocationPermissionDto.whileInUse;
}
