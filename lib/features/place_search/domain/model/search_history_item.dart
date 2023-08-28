import 'package:equatable/equatable.dart';
import 'package:places/core/domain/model/place.dart';

final class SearchHistoryItem extends Equatable {
  /// id бэкенда.
  final int id;
  final String name;
  final String imageUrl;

  const SearchHistoryItem({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  SearchHistoryItem.fromPlace(Place place)
      : id = place.id ?? -1,
        name = place.name,
        imageUrl = place.photoUrlList?.first ?? '';

  @override
  List<Object?> get props => [id];
}
