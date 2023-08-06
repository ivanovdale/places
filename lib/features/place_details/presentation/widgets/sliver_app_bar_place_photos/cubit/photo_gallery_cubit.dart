import 'package:flutter_bloc/flutter_bloc.dart';

part 'photo_gallery_state.dart';

class PhotoGalleryCubit extends Cubit<PhotoGalleryState> {
  PhotoGalleryCubit()
      : super(
          const PhotoGalleryState(activePage: 0),
        );

  void setActivePage(int page) {
    emit(
      state.copyWith(activePage: page),
    );
  }
}
