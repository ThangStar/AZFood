import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PainterPage extends StatefulWidget {
  const PainterPage({super.key});

  @override
  State<PainterPage> createState() => _PainterPageState();
}

class _PainterPageState extends State<PainterPage>
    with TickerProviderStateMixin {
  ui.Image? bg;
  late Animation<double> percent;
  late AnimationController controllerOval;
  int sumFull = 100;
  List<Particle> particles = [];

  void loadImage(String imageName) async {
    final data = await rootBundle.load('assets/images/$imageName');
    ui.Image bg = await decodeImageFromList(data.buffer.asUint8List());
    setState(() {
      this.bg = bg;
    });
  }

  generateParticle() {
    particles = List.generate(1000, (index) => Particle());
  }

  movingTimer() {
    ///Frame: 5 ms / 1 khung hình
    ///Cứ 5ms gọi hàm này 1 lần
    Timer.periodic(const Duration(milliseconds: 5), (timer) {
      setState(() {
        for (var e in particles) {
          ///mỗi item có 1 random target khác nhau => bay hướng khác nhau
          ///vd: tại pos 0, item có oX = 0.2, oY = 0.2 thì sẽ bay chéo
          e.offset += Offset(e.oX, e.oY);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    controllerOval = AnimationController(vsync: this, duration: 2000.ms);
    Tween<double> tween = Tween(begin: 0.0, end: sumFull.toDouble());
    percent = tween.animate(
        CurvedAnimation(parent: controllerOval, curve: Curves.fastOutSlowIn))
      ..drive(CurveTween(curve: Curves.fastOutSlowIn))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controllerOval.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          controllerOval.forward();
        }
        print(status);
      });
    controllerOval.forward();
    generateParticle();
    movingTimer();
    loadImage("3d.jpg");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Paiter"),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.1))),
              width: 300,
              height: 300,
              child: bg == null
                  ? const CircularProgressIndicator()
                  : FittedBox(
                      child: SizedBox(
                        width: bg!.width.toDouble(),
                        height: bg!.height.toDouble(),
                        child: CustomPaint(
                          painter: MyCustomPainter(
                              image: bg, percent: percent.value),
                          child: Center(
                            child: Text(
                              "${percent.value.toInt()}%",
                              style: const TextStyle(
                                  fontSize: 1000,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          CustomPaint(painter: MyParticle(particles: particles))
        ],
      ),
    );
  }
}

class Particle {
  late double oX;
  late double oY;
  late double size;
  late Offset offset;

  Particle() {
    oX = Utils.Range(-0.1, 0.1);
    oY = Utils.Range(-0.1, 0.1);
    size = Utils.Range(1, 10);
    final x = Utils.Range(0, 400);
    final y = Utils.Range(0, 400);
    offset = Offset(x, y);
  }
}

class Utils {
  static double Range(double min, double max) =>
      min + Random().nextDouble() * (max - min);
}

class MyParticle extends CustomPainter {
  final List<Particle> particles;

  MyParticle({required this.particles});

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    canvas.drawRect(const Rect.fromLTRB(10, 10, 100, 100), Paint());
    canvas.drawCircle(Offset(0, 0), 10, Paint());

    for (var e in particles) {
      canvas.drawCircle(
          e.offset,
          e.size,
          Paint()
            ..color = Colors.blueAccent
            ..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class MyCustomPainter extends CustomPainter {
  final ui.Image? image;
  final double percent;
  final int sumFull;

  MyCustomPainter(
      {super.repaint,
      required this.image,
      required this.percent,
      this.sumFull = 100});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.red;
    canvas.drawImage(image!, Offset.zero, paint);
    canvas.drawRect(const Rect.fromLTRB(10, 10, 200, 100), paint);

    final rectOval = Rect.fromCenter(
        center: const Offset(200, 200), width: 100, height: 100);
    paint.color = Colors.black87;
    canvas.drawOval(rectOval, paint);

    paint.color = Colors.purple;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 50, paint);

    paint.color = Colors.brown.withOpacity(0.4);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 200;
    final rectArcContainer = Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.height * 2 / 3,
        height: size.height * 2 / 3);
    canvas.drawArc(rectArcContainer, 1, pi * 2, false, paint);

    paint.color = Colors.brown;
    final rectArc = Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.height * 2 / 3,
        height: size.height * 2 / 3);
    canvas.drawArc(
        rectArc, -pi / 2, (pi * 2) / sumFull * percent, false, paint);

    final text = ui.Paragraph;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
