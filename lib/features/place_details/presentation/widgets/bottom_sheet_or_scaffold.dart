import 'package:flutter/material.dart';

class BottomSheetOrScaffold extends StatelessWidget {
  final bool isBottomSheet;
  final Widget scaffoldChild;
  final ScrollableWidgetBuilder bottomSheetBuilder;

  const BottomSheetOrScaffold({
    super.key,
    required this.isBottomSheet,
    required this.scaffoldChild,
    required this.bottomSheetBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return isBottomSheet
        ? DraggableScrollableSheet(
            initialChildSize: 0.9,
            maxChildSize: 0.9,
            minChildSize: 0.5,
            builder: (_, scrollController) => ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Scaffold(
                bottomSheet: bottomSheetBuilder(
                  _,
                  scrollController,
                ),
              ),
            ),
          )
        : Scaffold(
            body: scaffoldChild,
          );
  }
}
