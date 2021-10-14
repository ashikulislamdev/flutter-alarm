import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  const ClockView({ Key? key }) : super(key: key);

  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        
      });
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Transform.rotate(
        angle: -pi /2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter{

  var dateTime = DateTime.now();

  //Rotates 360 degrees in 60 seconds, means 1 sec rotates 6 digrees    (minite & second)
  //Rotates 360 degrees in 12 hours, means 1 hour rotates 30 digrees and 1 minites rotates 0.5 digrees  (hour)


  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()..color = Color(0xFF444974);

    var outLineBrush = Paint()
    ..color = Color(0xFFEAECFE)
    ..style = PaintingStyle.stroke
    ..strokeWidth= 16;

    var centerFillBrush = Paint()..color = Color(0xFFEAECFE);


    var secHandBrush = Paint()
    ..color = Colors.orange
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth= 8;

    var minHandBrush = Paint()
    ..shader = RadialGradient(colors: [Color(0xFFEA74AB), Color(0XFFC279FB)]).createShader(Rect.fromCircle(center: center, radius: radius))
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth= 12;

    var hourHandBrush = Paint()
    ..shader = RadialGradient(colors: [Colors.lightBlue, Colors.pink]).createShader(Rect.fromCircle(center: center, radius: radius))
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth= 16;

    var outerHourBrush = Paint()
    ..color = Color(0xFFEAECFF)
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 2;

    var outerMinuteBrush = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 1;  


    canvas.drawCircle(center, radius - 40, fillBrush);    //clock round
    canvas.drawCircle(center, radius - 40, outLineBrush);   //clock round border


    var hourHandX = centerX + 60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi /180);
    var hourHandY = centerX + 60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi /180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);    //hour bar line
    
    var minHandX = centerX + 75 * cos(dateTime.minute * 6 * pi /180);
    var minHandY = centerX + 75 * sin(dateTime.minute * 6 * pi /180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);    //munite bar line

    var secHandX = centerX + 90 * cos(dateTime.second * 6 * pi /180);
    var secHandY = centerX + 90 * sin(dateTime.second * 6 * pi /180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);    //second bar line
    
    canvas.drawCircle(center, 16, centerFillBrush);   //center small circle

    var outerCircleRadius = radius;
    var innerMinuteRadius = radius - 5;
    for (int i = 0; i < 360; i+= 6) {
      var x1 = centerX + outerCircleRadius * cos(i * pi /180);
      var y1 = centerX + outerCircleRadius * sin(i * pi /180);

      var x2 = centerX + innerMinuteRadius * cos(i * pi /180);
      var y2 = centerX + innerMinuteRadius * sin(i * pi /180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), outerMinuteBrush);
    }
    
    var innerHourRadius = radius - 15;
    for (double i = 0; i < 360; i+= 30) {
      var x1 = centerX + outerCircleRadius * cos(i * pi /180);
      var y1 = centerX + outerCircleRadius * sin(i * pi /180);

      var x2 = centerX + innerHourRadius * cos(i * pi /180);
      var y2 = centerX + innerHourRadius * sin(i * pi /180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), outerHourBrush);
    }

    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}