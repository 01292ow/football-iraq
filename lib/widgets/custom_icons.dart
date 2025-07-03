import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIcons {
  static Widget homeIcon({
    double size = 24,
    Color? color,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _HomeIconPainter(color: color ?? Colors.white),
      ),
    );
  }

  static Widget exploreIcon({
    double size = 24,
    Color? color,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ExploreIconPainter(color: color ?? Colors.white),
      ),
    );
  }

  static Widget uploadIcon({
    double size = 24,
    Color? color,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _UploadIconPainter(color: color ?? Colors.white),
      ),
    );
  }

  static Widget chatIcon({
    double size = 24,
    Color? color,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ChatIconPainter(color: color ?? Colors.white),
      ),
    );
  }

  static Widget profileIcon({
    double size = 24,
    Color? color,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ProfileIconPainter(color: color ?? Colors.white),
      ),
    );
  }
}

class _HomeIconPainter extends CustomPainter {
  final Color color;

  _HomeIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    
    // Home icon path based on the SVG
    path.moveTo(size.width * 0.125, size.height * 0.40625);
    path.lineTo(size.width * 0.5, size.height * 0.125);
    path.lineTo(size.width * 0.875, size.height * 0.40625);
    path.lineTo(size.width * 0.875, size.height * 0.84375);
    path.cubicTo(
      size.width * 0.875, size.height * 0.86934,
      size.width * 0.85767, size.height * 0.875,
      size.width * 0.84375, size.height * 0.875,
    );
    path.lineTo(size.width * 0.65625, size.height * 0.875);
    path.lineTo(size.width * 0.65625, size.height * 0.59375);
    path.lineTo(size.width * 0.34375, size.height * 0.59375);
    path.lineTo(size.width * 0.34375, size.height * 0.875);
    path.lineTo(size.width * 0.15625, size.height * 0.875);
    path.cubicTo(
      size.width * 0.14233, size.height * 0.875,
      size.width * 0.125, size.height * 0.86934,
      size.width * 0.125, size.height * 0.84375,
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ExploreIconPainter extends CustomPainter {
  final Color color;

  _ExploreIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Draw search circle
    canvas.drawCircle(
      Offset(size.width * 0.4375, size.height * 0.4375),
      size.width * 0.25,
      paint,
    );

    // Draw search handle
    final handlePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.4375, size.height * 0.4375),
      size.width * 0.15,
      handlePaint,
    );

    // Draw magnifying glass handle
    final handlePath = Path();
    handlePath.moveTo(size.width * 0.65, size.height * 0.65);
    handlePath.lineTo(size.width * 0.875, size.height * 0.875);
    
    final handleStroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(handlePath, handleStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _UploadIconPainter extends CustomPainter {
  final Color color;

  _UploadIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Vertical line
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.4167,
        size.height * 0.1667,
        size.width * 0.1667,
        size.height * 0.6667,
      ),
      paint,
    );

    // Horizontal line
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.1667,
        size.height * 0.4167,
        size.width * 0.6667,
        size.height * 0.1667,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ChatIconPainter extends CustomPainter {
  final Color color;

  _ChatIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    
    // Chat bubble
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.1667,
          size.height * 0.1667,
          size.width * 0.6667,
          size.height * 0.5833,
        ),
        Radius.circular(size.width * 0.0833),
      ),
    );

    // Chat tail
    path.moveTo(size.width * 0.2917, size.height * 0.75);
    path.lineTo(size.width * 0.0833, size.height * 0.9167);
    path.lineTo(size.width * 0.0833, size.height * 0.25);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ProfileIconPainter extends CustomPainter {
  final Color color;

  _ProfileIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Head circle
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.3333),
      size.width * 0.1667,
      paint,
    );

    // Body path
    final bodyPath = Path();
    bodyPath.moveTo(size.width * 0.1667, size.height * 0.8333);
    bodyPath.cubicTo(
      size.width * 0.1667, size.height * 0.7024,
      size.width * 0.3159, size.height * 0.5833,
      size.width * 0.5, size.height * 0.5833,
    );
    bodyPath.cubicTo(
      size.width * 0.6841, size.height * 0.5833,
      size.width * 0.8333, size.height * 0.7024,
      size.width * 0.8333, size.height * 0.8333,
    );
    bodyPath.lineTo(size.width * 0.1667, size.height * 0.8333);
    bodyPath.close();

    canvas.drawPath(bodyPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}