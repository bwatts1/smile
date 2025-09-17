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

class ShapesDemoScreen extends StatefulWidget {
  const ShapesDemoScreen({super.key});

  @override
  State<ShapesDemoScreen> createState() => _ShapesDemoScreenState();
}

class _ShapesDemoScreenState extends State<ShapesDemoScreen> {
  final List<Widget> paintedWidgets = [];
  CustomPainter? selectedPainter;

  void _handleTapOnCanvas(TapUpDetails details, BuildContext context) {
    if (selectedPainter == null) return;

    final RenderBox box = context.findRenderObject() as RenderBox;
    final localPosition = box.globalToLocal(details.globalPosition);

    setState(() {
      paintedWidgets.add(
        PositionedPainterBox(
          position: localPosition,
          painter: selectedPainter!,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shapes Drawing Demo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTapUp: (details) => _handleTapOnCanvas(details, context),
              child: Stack(
                children: [
                  Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.lightBlue, Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                ...paintedWidgets,
                ],
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DrawEmoji(
                    painter: CirclePainter(),
                    onTap: () {
                      setState(() {
                        selectedPainter = CirclePainter();
                      });
                    },
                  ),
                  SizedBox(width: 15),
                  DrawEmoji(
                    painter: RectanglePainter(),
                    onTap: () {
                      setState(() {
                        selectedPainter = RectanglePainter();
                      });
                    },
                  ),
                  SizedBox(width: 15),
                  DrawEmoji(
                    painter: ArcPainter(),
                    onTap: () {
                      setState(() {
                        selectedPainter = ArcPainter();
                      });
                    },
                  ),
                  SizedBox(width: 15),
                  DrawEmoji(
                    painter: LinePainter(),
                    onTap: () {
                      setState(() {
                        selectedPainter = LinePainter();
                      });
                    },
                  ),
                  SizedBox(width: 15),
                  DrawEmoji(
                    painter: OvalPainter(),
                    onTap: () {
                      setState(() {
                        selectedPainter = OvalPainter();
                      });
                    },
                  ),
                  SizedBox(width: 15),
                  DrawEmoji(
                    painter: Smile(),
                    onTap: () {
                      setState(() {
                        selectedPainter = Smile();
                      });
                    },
                  ),
                  SizedBox(width: 15),
                  DrawEmoji(
                    painter: Party(),
                    onTap: () {
                      setState(() {
                        selectedPainter = Party();
                      });
                    },
                  ),
                  SizedBox(width: 15),
                  DrawEmoji(
                    painter: Heart(),
                    onTap: () {
                      setState(() {
                        selectedPainter = Heart();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PositionedPainterBox extends StatelessWidget {
  final Offset position;
  final CustomPainter painter;
  final Size size;

  const PositionedPainterBox({
    super.key,
    required this.position,
    required this.painter,
    this.size = const Size(100, 100),
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx - size.width/2,
      top: position.dy - size.height,
      child: CustomPaint(
        painter: painter,
        size: size,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: CustomPaint(
          painter: painter,
          size: const Size(60, 60),
        ),
      ),
    );
  }
}

// ======= Shape Painters =======

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 30, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: 60, height: 40);
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: 60, height: 60);
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawArc(rect, 0, pi, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final start = Offset(size.width * 0.2, size.height / 2);
    final end = Offset(size.width * 0.8, size.height / 2);
    final paint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 3;
    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class OvalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: 80, height: 40);
    final paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;
    canvas.drawOval(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Smile extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Face
    final facePaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 30, facePaint);

    // Eyes
    final eyePaint = Paint()..color = Colors.black;
    canvas.drawCircle(Offset(center.dx - 10, center.dy - 10), 4, eyePaint);
    canvas.drawCircle(Offset(center.dx + 10, center.dy - 10), 4, eyePaint);

    // Mouth
    final mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    final mouthRect = Rect.fromCenter(center: Offset(center.dx, center.dy + 5), width: 20, height: 10);
    canvas.drawArc(mouthRect, 0, pi, false, mouthPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Party extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw face using Smile painter
    Smile().paint(canvas, size);

    // Draw party hat (directly above the face)
    final hatHeight = 50.0;
    final hatWidth = 40.0;

    final faceRadius = 25.0; // assuming Smile face radius is 80
    final hatBottomY = centerY - faceRadius;

    final hatTop = Offset(centerX, hatBottomY - hatHeight); // tip of hat
    final hatLeft = Offset(centerX - hatWidth / 2, hatBottomY);
    final hatRight = Offset(centerX + hatWidth / 2, hatBottomY);

    final hatPath = Path()
      ..moveTo(hatTop.dx, hatTop.dy)
      ..lineTo(hatLeft.dx, hatLeft.dy)
      ..lineTo(hatRight.dx, hatRight.dy)
      ..close();

    final hatPaint = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.fill;

    canvas.drawPath(hatPath, hatPaint);

    // Draw a blue circle at the tip of the hat
    final tipPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(hatTop, 8, tipPaint);

    // Draw fixed-position confetti (not random)
    final confettiPaints = [
      Paint()..color = Colors.red,
      Paint()..color = Colors.green,
      Paint()..color = Colors.orange,
      Paint()..color = Colors.purple,
      Paint()..color = Colors.yellow,
    ];

    final confettiOffsetsLeft = [
      Offset(centerX - 40, centerY - 70),
      Offset(centerX - 55, centerY - 50),
      Offset(centerX - 40, centerY - 0),
      Offset(centerX - 50, centerY - 30),
      Offset(centerX - 40, centerY - 60),
    ];

    final confettiOffsetsRight = [
      Offset(centerX + 40, centerY - 90),
      Offset(centerX + 50, centerY - 70),
      Offset(centerX + 60, centerY - 40),
      Offset(centerX + 55, centerY - 80),
      Offset(centerX + 40, centerY - 20),
    ];


    for (int i = 0; i < confettiOffsetsLeft.length; i++) {
      canvas.drawRect(
        Rect.fromCenter(center: confettiOffsetsLeft[i], width: 16, height: 16),
        confettiPaints[i % confettiPaints.length],
      );
      canvas.drawRect(
        Rect.fromCenter(center: confettiOffsetsRight[i], width: 16, height: 16),
        confettiPaints[(i + 1) % confettiPaints.length],
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


class Heart extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, size.height * 0.35); // Start at the top center

    // Left curve
    path.cubicTo(
      size.width * 0.1, size.height * -0.2, // Control point 1
      size.width * -0.2, size.height * 0.6, // Control point 2
      size.width / 2, size.height, // End point
    );

    // Right curve
    path.cubicTo(
      size.width * 1.2, size.height * 0.6, // Control point 1
      size.width * 0.9, size.height * -0.2, // Control point 2
      size.width / 2, size.height * 0.35, // End point
    );

    path.close(); // Close the path to create a filled shape

    canvas.drawPath(path, paint);
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
