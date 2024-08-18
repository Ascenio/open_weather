import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide TextStyle;
import 'package:open_weather/weather/domain/entities/weather_data_entity.dart';
import 'package:open_weather/weather/presentation/widgets/custom_colors.dart';

final class ForecastPainter extends CustomPainter {
  const ForecastPainter({
    required this.forecast,
    required this.progress,
    required this.textColor,
    this.stepSize = 5,
    this.textMargin = 24,
    super.repaint,
  });

  final List<WeatherDataEntity> forecast;
  final double progress;
  final Color textColor;
  final int stepSize;
  final double textMargin;

  int _smallestMultipleOfStep(int x) => x - x % stepSize;
  int _largestMultipleOfStep(int x) => _smallestMultipleOfStep(x) + stepSize;

  @override
  void paint(Canvas canvas, Size size) {
    final minimum = _smallestMultipleOfStep(
      forecast
          .fold(
            double.infinity,
            (minimum, data) => min(minimum, data.temperature),
          )
          .floor(),
    );
    final maximum = _largestMultipleOfStep(
      forecast
          .fold(
            double.negativeInfinity,
            (minimum, data) => max(minimum, data.temperature),
          )
          .ceil(),
    );

    _drawYAxis(
      size: size,
      minimum: minimum,
      maximum: maximum,
      canvas: canvas,
      stepSize: stepSize,
    );
    _plotLine(
      size: size,
      minimum: minimum,
      maximum: maximum,
      canvas: canvas,
    );
  }

  void _drawYAxis({
    required Size size,
    required int minimum,
    required int maximum,
    required Canvas canvas,
    required int stepSize,
  }) {
    for (var y = minimum; y <= maximum; y += stepSize) {
      final paragraph = _buildText(text: y.toString(), size: size);
      final dy = (size.height - paragraph.height) *
          (1 -
              _inverseLerp(
                value: y.toDouble(),
                min: minimum.toDouble(),
                max: maximum.toDouble(),
              ));
      canvas.drawParagraph(paragraph, Offset(0, dy));
      final lineDy = dy + paragraph.height / 2;
      canvas.drawLine(
        Offset(textMargin, lineDy),
        Offset(size.width, lineDy),
        Paint()..color = textColor.withOpacity(0.2),
      );
    }
  }

  void _plotLine({
    required Size size,
    required int minimum,
    required int maximum,
    required Canvas canvas,
  }) {
    final path = Path();
    final dataCount = (forecast.length * progress).round();
    final paint = Paint();
    for (var i = 0; i < dataCount; i++) {
      final dx = textMargin + (size.width - textMargin) / forecast.length * i;
      final dy = size.height *
          (1 -
              _inverseLerp(
                value: forecast[i].temperature,
                min: minimum.toDouble(),
                max: maximum.toDouble(),
              ));
      if (i == 0) {
        path.moveTo(dx, dy);
      } else {
        path.lineTo(dx, dy);
      }
      paint
        ..style = PaintingStyle.stroke
        ..color = CustomColors.primary;
      canvas.drawPath(path, paint);
      if (i == 0 || i == dataCount - 1) {
        paint
          ..style = PaintingStyle.fill
          ..color = CustomColors.primary;
        canvas.drawCircle(Offset(dx, dy), 4, paint);
      }
    }
  }

  Paragraph _buildText({
    required String text,
    required Size size,
  }) {
    final paragraphBuilder = ParagraphBuilder(ParagraphStyle())
      ..pushStyle(TextStyle(
        color: textColor,
      ))
      ..addText(text);
    final paragraph = paragraphBuilder.build();
    paragraph.layout(ParagraphConstraints(width: size.width));
    return paragraph;
  }

  double _inverseLerp({
    required double value,
    required double min,
    required double max,
  }) {
    return (value - min) / (max - min);
  }

  @override
  bool shouldRepaint(ForecastPainter oldDelegate) {
    return !listEquals(forecast, oldDelegate.forecast) ||
        progress != oldDelegate.progress ||
        stepSize != oldDelegate.stepSize ||
        textMargin != oldDelegate.textMargin;
  }
}
