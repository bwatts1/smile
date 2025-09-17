import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const ShapesDemoApp());
}


class ShapesDemoApp extends StatelessWidget {
  const ShapesDemoApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shapes Drawing Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ShapesDemoScreen(),
    );
  }
}
CustomPainter? selectedPainter;

class ShapesDemoScreen extends StatelessWidget {
  const ShapesDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shapes Drawing Demo'),
      ),
      body: Column(
        children: [
          // Enlarged selected canvas
          Expanded(
            child: Center(
              child: selectedPainter != null
                  ? CustomPaint(
                      painter: selectedPainter,
                      size: const Size(200, 200),
                    )
                  : const Text("Select a shape below"),
            ),
          ),
          const Divider(),
          // Row of selectable canvases
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DrawEmoji(
                  painter: CirclePainter(),
                  onTap: () {
                    selectedPainter = CirclePainter();
                    (context as Element).markNeedsBuild();
                  },
                ),
                DrawEmoji(
                  painter: RectanglePainter(),
                  onTap: () {
                    selectedPainter = RectanglePainter();
                    (context as Element).markNeedsBuild();
                  },
                ),
                DrawEmoji(
                  painter: ArcPainter(),
                  onTap: () {
                    selectedPainter = ArcPainter();
                    (context as Element).markNeedsBuild();
                  },
                ),
                DrawEmoji(
                  painter: LinePainter(),
                  onTap: () {
                    selectedPainter = LinePainter();
                    (context as Element).markNeedsBuild();
                  },
                ),
                DrawEmoji(
                  painter: OvalPainter(),
                  onTap: () {
                    selectedPainter = OvalPainter();
                    (context as Element).markNeedsBuild();
                  },
                ),
                DrawEmoji(
                  painter: Smile(),
                  onTap: () {
                    selectedPainter = Smile();
                    (context as Element).markNeedsBuild();
                  },
                ),
                DrawEmoji(
                  painter: Party(),
                  onTap: () {
                    selectedPainter = Party();
                    (context as Element).markNeedsBuild();
                  },
                ),
                DrawEmoji(
                  painter: Heart(),
                  onTap: () {
                    selectedPainter = Heart();
                    (context as Element).markNeedsBuild();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DrawEmoji extends StatelessWidget {
  final CustomPainter painter;
  final VoidCallback onTap;
  const DrawEmoji({super.key, required this.painter, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: painter,
        size: const Size(200, 200),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final circlePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(centerX, centerY), 50, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class RectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final rectPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromCenter(center: Offset(centerX, centerY), width: 100, height: 60),
      rectPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final arcPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    canvas.drawArc(
      Rect.fromCenter(center: Offset(centerX, centerY), width: 100, height: 100),
      0, // start angle
      3.14, // sweep angle (half-circle)
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final start = Offset(size.width / 4, size.height / 2);
    final end = Offset(3 * size.width / 4, size.height / 2);

    final linePaint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 4;

    canvas.drawLine(start, end, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class OvalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final ovalPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    canvas.drawOval(
      Rect.fromCenter(center: Offset(centerX, centerY), width: 120, height: 60),
      ovalPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
class Smile extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw face (circle)
    final facePaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX, centerY), 80, facePaint);

    // Draw eyes (two small circles)
    final eyePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX - 30, centerY - 20), 10, eyePaint);
    canvas.drawCircle(Offset(centerX + 30, centerY - 20), 10, eyePaint);

    // Draw mouth (arc)
    final mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    canvas.drawArc(
      Rect.fromCenter(center: Offset(centerX, centerY + 10), width: 60, height: 40),
      0, // start angle in radians
      pi, // sweep angle in radians (180 degrees)
      false,
      mouthPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
class BasicShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Determine the center of the canvas
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final squareOffset = Offset(centerX - 80, centerY);
    final circleOffset = Offset(centerX, centerY);
    final arcOffset = Offset(centerX + 80, centerY);
    final rectOffset = Offset(centerX - 160, centerY);
    final lineStart = Offset(centerX - 200, centerY - 50);
    final lineEnd = Offset(centerX - 140, centerY + 50);
    final ovalOffset = Offset(centerX + 160, centerY);

    // Draw a square
    final squarePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(center: squareOffset, width: 60, height: 60),
      squarePaint,
    );

    // Draw a circle
    final circlePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(circleOffset, 30, circlePaint);

    // Draw an arc
    final arcPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    canvas.drawArc(
      Rect.fromCenter(center: arcOffset, width: 60, height: 60),
      0, // start angle in radians
      2.1, // sweep angle in radians (about 120 degrees)
      false, // whether to use center
      arcPaint,
    );

    // Draw a rectangle
    final rectPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(center: rectOffset, width: 80, height: 40),
      rectPaint,
    );

    // Draw a line
    final linePaint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 3;
    canvas.drawLine(lineStart, lineEnd, linePaint);

    // Draw an oval
    final ovalPaint = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(center: ovalOffset, width: 80, height: 40),
      ovalPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
class Party extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw face using Smile painter
    Smile().paint(canvas, size);

    // Draw party hat (triangle on top of head)
    final hatHeight = 50.0;
    final hatWidth = 60.0;
    final hatTop = Offset(centerX, centerY - 80 - hatHeight); // top of hat above face
    final hatLeft = Offset(centerX - hatWidth / 2, centerY - 80);
    final hatRight = Offset(centerX + hatWidth / 2, centerY - 80);

    final hatPath = Path()
      ..moveTo(hatTop.dx, hatTop.dy)
      ..lineTo(hatLeft.dx, hatLeft.dy)
      ..lineTo(hatRight.dx, hatRight.dy)
      ..close();

    final hatPaint = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.fill;

    canvas.drawPath(hatPath, hatPaint);

    // Optional: Draw a circle at the tip of the hat
    final tipPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawCircle(hatTop, 8, tipPaint);

    // Draw confetti on both sides
    final random = Random();
    for (int i = 0; i < 15; i++) {
      final confettiPaint = Paint()
        ..color = Colors.primaries[random.nextInt(Colors.primaries.length)]
        ..style = PaintingStyle.fill;
      // Left side
      final dxLeft = centerX - 50 - random.nextDouble() * 80;
      final dyLeft = centerY - 50 - random.nextDouble() * 160;
      canvas.drawRect(
        Rect.fromCenter(center: Offset(dxLeft, dyLeft), width: 16, height: 16),
        confettiPaint,
      );
      // Right side
      final confettiPaintRight = Paint()
        ..color = Colors.primaries[random.nextInt(Colors.primaries.length)]
        ..style = PaintingStyle.fill;
      final dxRight = centerX + 50 + random.nextDouble() * 80;
      final dyRight = centerY - 50 - random.nextDouble() * 160;
      canvas.drawRect(
        Rect.fromCenter(center: Offset(dxRight, dyRight), width: 16, height: 16),
        confettiPaintRight,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
class Heart extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final heartPath = Path()
      ..moveTo(centerX, centerY + 20)
      ..cubicTo(centerX - 50, centerY - 30, centerX - 80, centerY + 20, centerX, centerY + 80)
      ..cubicTo(centerX + 80, centerY + 20, centerX + 50, centerY - 30, centerX, centerY + 20)
      ..close();

    final heartPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    canvas.drawPath(heartPath, heartPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
class CombinedShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Background gradient
    final backgroundGradient = RadialGradient(
      center: Alignment.center,
      radius: 0.8,
      colors: [Colors.blue.shade100, Colors.white],
    );
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..shader = backgroundGradient.createShader(
          Rect.fromLTWH(0, 0, size.width, size.height),
        ),
    );

    // Draw a sun (circle with rays)
    final sunPaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX, centerY - 40), 40, sunPaint);

    // Sun rays (lines)
    final rayPaint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 3;
    for (int i = 0; i < 8; i++) {
      final angle = i * (pi / 4); // Use pi from dart:math
      final dx = cos(angle) * 60;
      final dy = sin(angle) * 60;
      canvas.drawLine(
        Offset(centerX, centerY - 40),
        Offset(centerX + dx, centerY - 40 + dy),
        rayPaint,
      );
    }

    // Draw a house (square with triangle roof)
    final housePaint = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(center: Offset(centerX, centerY + 40), width: 80, height: 80),
      housePaint,
    );
    final roofPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    final roofPath = Path()
      ..moveTo(centerX - 60, centerY)
      ..lineTo(centerX + 60, centerY)
      ..lineTo(centerX, centerY - 60)
      ..close();
    canvas.drawPath(roofPath, roofPaint);

    // Draw a door (rectangle)
    final doorPaint = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(center: Offset(centerX, centerY + 60), width: 30, height: 50),
      doorPaint,
    );

    // Draw windows (squares)
    final windowPaint = Paint()
      ..color = Colors.blue.shade200
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(center: Offset(centerX - 25, centerY + 20), width: 20, height: 20),
      windowPaint,
    );
    canvas.drawRect(
      Rect.fromCenter(center: Offset(centerX + 25, centerY + 20), width: 20, height: 20),
      windowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class StyledShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw a gradient-filled rectangle
    final rectGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Colors.red, Colors.blue],
    );
    final rect = Rect.fromCenter(center: Offset(centerX, centerY - 100), width: 200, height: 60);
    canvas.drawRect(
      rect,
      Paint()
        ..shader = rectGradient.createShader(rect)
        ..style = PaintingStyle.fill,
    );

    // Draw a circle with a border
    final circlePaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    final circleBorderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(Offset(centerX - 80, centerY), 40, circlePaint);
    canvas.drawCircle(Offset(centerX - 80, centerY), 40, circleBorderPaint);

    // Draw a transparent oval
    final ovalPaint = Paint()
      ..color = Colors.purple.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(center: Offset(centerX + 80, centerY), width: 100, height: 60),
      ovalPaint,
    );

    // Draw a dashed line using a custom path effect
    final dashPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    // We draw a series of short lines and spaces
    final path = Path();
    double startX = centerX - 100;
    const dashLength = 10.0;
    const spaceLength = 5.0;
    while (startX < centerX + 100) {
      path.moveTo(startX, centerY + 80);
      path.lineTo(min(startX + dashLength, centerX + 100), centerY + 80);
      startX += dashLength + spaceLength;
    }
    canvas.drawPath(path, dashPaint);

    // Draw a gradient arc
    final arcGradient = SweepGradient(
      center: Alignment.centerRight,
      startAngle: 0,
      endAngle: pi, // Use pi from dart:math
      colors: [Colors.red, Colors.yellow, Colors.green],
    );
    final arcRect = Rect.fromCenter(center: Offset(centerX, centerY + 100), width: 120, height: 120);
    final arcPaint = Paint()
      ..shader = arcGradient.createShader(arcRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCenter(center: Offset(centerX, centerY + 100), width: 100, height: 100),
      0, // start angle
      2.5, // sweep angle
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
