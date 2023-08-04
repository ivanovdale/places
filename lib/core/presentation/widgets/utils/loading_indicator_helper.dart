import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

/// Индикатор загрузки картинки.
abstract final class LoadingIndicatorHelper {
  static Widget progressIndicatorBuilder(
    BuildContext _,
    String __,
    DownloadProgress downloadProgress,
  ) {
    return Center(
      child: CupertinoActivityIndicator.partiallyRevealed(
        progress: downloadProgress.progress ?? 0,
      ),
    );
  }
}
