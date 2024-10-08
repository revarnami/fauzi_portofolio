import 'package:flutter/material.dart';

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class DiagonalHalfRectangle extends StatelessWidget {

  const DiagonalHalfRectangle({required this.size, required this.color, super.key});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: DiagonalHalfRectanglePainter(color),
      ),
    );
  }
}

class DiagonalHalfRectanglePainter extends CustomPainter {

  DiagonalHalfRectanglePainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    // Define the large rectangle
    final largeRect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Create a path for the combined shape
    final path = Path()
      ..fillType = PathFillType.evenOdd
      ..addRRect(
        RRect.fromRectAndCorners(
          largeRect,
        ),
      )
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    // Draw the path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}