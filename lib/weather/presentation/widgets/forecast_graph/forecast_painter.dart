import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide TextStyle;
import 'package:open_weather/weather/domain/entities/weather_data_entity.dart';

final class ForecastPainter extends CustomPainter {
  const ForecastPainter({
    required this.forecast,
    required this.progress,
    required this.primaryColor,
    this.steps = 6,
    this.textMargin = 32,
    super.repaint,
  });

  final List<WeatherDataEntity> forecast;
  final double progress;
  final Color primaryColor;
  final double steps;
  final double textMargin;

  @override
  void paint(Canvas canvas, Size size) {
    final minimum = forecast
        .fold(
          double.infinity,
          (minimum, data) => min(minimum, data.temperature),
        )
        .floor();
    final maximum = forecast
        .fold(
          double.negativeInfinity,
          (minimum, data) => max(minimum, data.temperature),
        )
        .ceil();

    final stepSize = size.height / steps;
    for (var i = 0; i < steps; i++) {
      final y = minimum + i * ((maximum - minimum) / steps).floor();
      final paragraph = _buildText(text: y.toString(), size: size);
      final dy = size.height - paragraph.height - stepSize * i;
      canvas.drawParagraph(paragraph, Offset(0, dy));
    }

    final path = Path();
    final dataCount = (forecast.length * progress).round();
    final paint = Paint();
    for (var i = 0; i < dataCount; i++) {
      final dx = textMargin + (size.width - textMargin) / forecast.length * i;
      final dy = size.height *
          (1 - (forecast[i].temperature - minimum) / (maximum - minimum));
      if (i == 0) {
        path.moveTo(dx, dy);
      } else {
        path.lineTo(dx, dy);
      }
      paint
        ..style = PaintingStyle.stroke
        ..color = primaryColor;
      canvas.drawPath(path, paint);
      if (i == 0 || i == dataCount - 1) {
        paint
          ..style = PaintingStyle.fill
          ..color = primaryColor;
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
        color: Colors.black,
      ))
      ..addText(text);
    final paragraph = paragraphBuilder.build();
    paragraph.layout(ParagraphConstraints(width: size.width));
    return paragraph;
  }

  @override
  bool shouldRepaint(ForecastPainter oldDelegate) {
    return !listEquals(forecast, oldDelegate.forecast) ||
        progress != oldDelegate.progress ||
        primaryColor != oldDelegate.primaryColor ||
        steps != oldDelegate.steps ||
        textMargin != oldDelegate.textMargin;
  }
}
