import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class CustomCircularLoadingIndicator extends StatefulWidget {
  const CustomCircularLoadingIndicator({super.key});

  @override
  State<CustomCircularLoadingIndicator> createState() =>
      _CustomCircularLoadingIndicatorState();
}

class _CustomCircularLoadingIndicatorState
    extends State<CustomCircularLoadingIndicator> {
  static const _turnsDuration = Duration(milliseconds: 350);

  late final StreamSubscription<dynamic> _turnsSubscription;
  double _turns = 0;

  @override
  void initState() {
    super.initState();
    _turnsSubscription = Stream.periodic(_turnsDuration).listen(
      (event) => _changeRotation(),
    );
  }

  @override
  void dispose() {
    _turnsSubscription.cancel();
    super.dispose();
  }

  void _changeRotation() => setState(() => _turns -= 1 / 2);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedRotation(
      turns: _turns,
      duration: _turnsDuration,
      child: CustomPaint(
        key: ValueKey(_turns),
        size: const Size(28, 28),
        painter: _CustomCircularProgressIndicatorPainter(
          colors: [
            colorScheme.secondary,
            colorScheme.secondaryContainer,
          ],
          strokeWidth: 6,
        ),
      ),
    );
  }
}

class _CustomCircularProgressIndicatorPainter extends CustomPainter {
  _CustomCircularProgressIndicatorPainter({
    required this.colors,
    required this.strokeWidth,
  });

  final List<Color> colors;
  final double strokeWidth;

  double _getRadius(Size size) => math.min(size.width, size.height) / 2;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = _getRadius(size);

    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..shader = SweepGradient(
        center: Alignment.centerRight,
        colors: colors,
        endAngle: 6,
      ).createShader(Rect.fromLTWH(0, 0, radius, radius));

    canvas.drawArc(Offset.zero & size, 0, 5, false, paint);
  }

  @override
  bool shouldRepaint(_CustomCircularProgressIndicatorPainter oldPainter) {
    return false;
  }
}
