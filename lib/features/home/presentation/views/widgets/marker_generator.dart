
import 'dart:ui' as ui;
import 'package:estegatha/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> createCustomMarker(String text, {Color color = ConstantColors.primary, double size = 100.0,}) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);

  final Paint paint = Paint()..color = color;
  final RRect rrect = RRect.fromRectAndRadius(Rect.fromLTWH(0.0, 0.0, size, size), Radius.circular(20));
  canvas.drawRRect(rrect, paint);

  TextPainter painter = TextPainter(
    textDirection: TextDirection.ltr,
  );

  painter.text = TextSpan(
    text: text,
    style: TextStyle(
      fontSize: size / 2.5, // Adjust the font size relative to the marker size
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  );

  painter.layout();
  painter.paint(
    canvas,
    Offset((size - painter.width) / 2, (size - painter.height) / 2),
  );

  final img = await pictureRecorder.endRecording().toImage(size.toInt(), size.toInt());
  final data = await img.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
}
