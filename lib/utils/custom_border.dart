import 'dart:math';

import 'package:flutter/material.dart';

class CustomInputBorder extends InputBorder {
  final BorderRadius borderRadius;

  const CustomInputBorder(
      {super.borderSide = const BorderSide(width: 1, color: Color(0xFF0058aa)),
      this.borderRadius = BorderRadius.zero});

  @override
  InputBorder copyWith({BorderSide? borderSide, BorderRadius? borderRadius}) {
    return CustomInputBorder(
        borderSide: borderSide ?? this.borderSide,
        borderRadius: borderRadius ?? this.borderRadius);
  }

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.only(left: borderSide.width, right: borderSide.width);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(
        borderRadius
            .resolve(textDirection)
            .toRRect(rect)
            .deflate(borderSide.width),
      );
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  bool get isOutline => true;

  @override
  void paint(Canvas canvas, Rect rect,
      {double? gapStart,
      double gapExtent = 0.0,
      double gapPercentage = 0.0,
      TextDirection? textDirection}) {
    Paint? paint;

    paint = createPaintForBorder(borderSide);
    if (borderRadius.topLeft.x != 0.0 && paint != null) {
      canvas.drawArc(
        rectForCorner(
          rect.topLeft,
          borderRadius.topLeft,
          1,
          1,
          borderSide.width,
        ),
        pi / 2 * 2,
        pi / 2,
        false,
        paint,
      );
    }

    paint = createPaintForBorder(borderSide);
    if (borderRadius.topRight.x != 0.0 && paint != null) {
      canvas.drawArc(
        rectForCorner(
          rect.topRight,
          borderRadius.topRight,
          -1,
          1,
          borderSide.width,
        ),
        pi / 2 * 3,
        pi / 2,
        false,
        paint,
      );
    }

    paint = createPaintForBorder(borderSide);
    if (paint != null) {
      canvas.drawLine(
        rect.topRight +
            Offset(
              -1 * (borderSide.width) / 2,
              borderRadius.topRight.y +
                  (borderRadius.topRight.x == 0 ? (borderSide.width) : 0.0),
            ),
        rect.bottomRight +
            Offset(
              -1 * (borderSide.width) / 2,
              -borderRadius.bottomRight.y,
            ),
        paint,
      );
    }

    paint = createPaintForBorder(borderSide);
    if (borderRadius.bottomRight.x != 0.0 && paint != null) {
      canvas.drawArc(
        rectForCorner(
          rect.bottomRight,
          borderRadius.bottomRight,
          -1,
          -1,
          borderSide.width,
        ),
        pi / 2 * 0,
        pi / 2,
        false,
        paint,
      );
    }

    paint = createPaintForBorder(borderSide);
    if (borderRadius.bottomLeft.x != 0.0 && paint != null) {
      canvas.drawArc(
        rectForCorner(
          rect.bottomLeft,
          borderRadius.bottomLeft,
          1,
          -1,
          borderSide.width,
        ),
        pi / 2 * 1,
        pi / 2,
        false,
        paint,
      );
    }

    paint = createPaintForBorder(borderSide);
    if (paint != null) {
      canvas.drawLine(
        rect.bottomLeft +
            Offset(
              (borderSide.width) / 2,
              -borderRadius.bottomLeft.y -
                  (borderRadius.bottomLeft.x == 0 ? (borderSide.width) : 0.0),
            ),
        rect.topLeft + Offset((borderSide.width) / 2, borderRadius.topLeft.y),
        paint,
      );
    }
  }

  Rect rectForCorner(
    Offset offset,
    Radius radius,
    num signX,
    num signY, [
    double? sideWidth,
  ]) {
    sideWidth ??= 0;
    final double d = sideWidth / 2;
    final double borderRadiusX = radius.x - d;
    final double borderRadiusY = radius.y - d;
    final Rect rect = Rect.fromPoints(
      offset + Offset(signX.sign * d, signY.sign * d),
      offset +
          Offset(signX.sign * d, signY.sign * d) +
          Offset(
            signX.sign * 2 * borderRadiusX,
            signY.sign * 2 * borderRadiusY,
          ),
    );

    return rect;
  }

  Paint? createPaintForBorder(BorderSide? side) {
    if (side == null) return null;

    return Paint()
      ..style = PaintingStyle.stroke
      ..color = side.color
      ..strokeWidth = side.width;
  }

  @override
  ShapeBorder scale(double t) {
    return CustomInputBorder(
        borderSide: borderSide.scale(t), borderRadius: borderRadius);
  }
}
