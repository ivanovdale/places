import 'package:flutter/cupertino.dart';

class LoadingIndicator {
  static Widget imageLoadingBuilder(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) {
    if (loadingProgress == null) {
      return child;
    }

    return Center(
      child: CupertinoActivityIndicator.partiallyRevealed(
        progress: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
            : 0,
      ),
    );
  }
}
