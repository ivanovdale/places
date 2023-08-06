part of 'photo_gallery_cubit.dart';

final class PhotoGalleryState {
  final int activePage;

  const PhotoGalleryState({
    required this.activePage,
  });

  PhotoGalleryState copyWith({
    int? activePage,
  }) {
    return PhotoGalleryState(
      activePage: activePage ?? this.activePage,
    );
  }
}
