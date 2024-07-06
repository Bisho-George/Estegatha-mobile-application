import 'dart:ui';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> createCustomMarkerBitmap() async {
  final user = await HelperFunctions.getUser();
  final TextSpan span = TextSpan(
    style: TextStyle(
      color: Colors.white,
      fontSize: 50.0,
      fontWeight: FontWeight.bold,
    ),
    text: user.username[0],
  );

  final TextPainter tp = TextPainter(
    text: span,
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  tp.layout();
  final PictureRecorder recorder = PictureRecorder();
  final Canvas canvas = Canvas(recorder);

  final double width = tp.width + 60;
  final double height = tp.height + 20;
  final double borderRadius = 20.0;

  // Draw the rounded rectangle
  final Paint paint = Paint()..color = ConstantColors.primary;
  final RRect rRect = RRect.fromLTRBR(
    0,
    0,
    width,
    height,
    Radius.circular(borderRadius),
  );

  canvas.drawRRect(rRect, paint);

  // Draw the text
  tp.paint(canvas, Offset(30.0, 10.0));

  final img =
      await recorder.endRecording().toImage(width.toInt(), height.toInt());
  final data = await img.toByteData(format: ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
}
