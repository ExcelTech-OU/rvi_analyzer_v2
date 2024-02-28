import 'package:flutter/material.dart';

class CustomSliderThumbRect extends SliderComponentShape {
  final double thumbRadius;
  final thumbHeight;
  final int min;
  final int max;
  final LinearGradient gradient;

  const CustomSliderThumbRect({
    required this.thumbRadius,
    this.thumbHeight,
    required this.min,
    required this.max,
    this.gradient = const LinearGradient(
      colors: [
        Colors.red,
        Colors.yellow,
      ],
    ),
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    assert(sliderTheme.activeTrackColor != null);
    final Canvas canvas = context.canvas;

    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: center, width: thumbHeight * 0.85, height: thumbHeight * .65),
      Radius.circular(thumbRadius * .4),
    );

    final rRectr = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: center, width: thumbHeight * 0.7, height: thumbHeight * .52),
      Radius.circular(thumbRadius * .4),
    );

    final paint = Paint()
      ..color = gradient.colors[getValueInt(value)] //Thumb Background Color
      ..style = PaintingStyle.fill;

    final paint1 = Paint()
      ..color = Colors.white //Thumb Background Color
      ..style = PaintingStyle.fill;

    TextSpan span = TextSpan(
        style: TextStyle(
            fontSize: thumbHeight * .2,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 1),
        text: '| | |');
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawRRect(rRect, paint1);
    canvas.drawRRect(rRectr, paint);
    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return (min + (max - min) * value).round().toString();
  }

  int getValueInt(double value) {
    return ((max) * value).round();
  }
}
