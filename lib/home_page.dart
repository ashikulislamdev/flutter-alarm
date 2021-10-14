import 'package:intl/intl.dart';
import 'package:alarm/clock_view.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatedTime = DateFormat('HH:mm').format(now);
    var formatedDate = DateFormat('EEE, d MMM').format(now);

    var timeZoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (!timeZoneString.startsWith('-')) offsetSign = '+';
    print(timeZoneString);

    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: deprecated_member_use
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: buildFlatButton('Clock', "assets/images/clock_icon.png"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: buildFlatButton('Alarm', "assets/images/alarm_icon.png"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: buildFlatButton('Timer', "assets/images/timer_icon.png"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: buildFlatButton('Stopwatch', "assets/images/stopwatch_icon.png"),
              ),
            ],
          ),

          VerticalDivider(color: Colors.white, width: 1,),

          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(flex:1, fit: FlexFit.tight, child: Text("Clock", style: TextStyle(color: Colors.white, fontSize: 24))),

                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(formatedTime, style: TextStyle(color: Colors.white, fontSize: 64)),
                        Text(formatedDate, style: TextStyle(color: Colors.white, fontSize: 20)),
                      ],
                    ),
                  ),

                  Flexible(flex: 4, fit: FlexFit.tight, child: Align(
                    alignment: Alignment.center,
                    child: ClockView(
                      size: 220 /* MediaQuery.of(context)size.height / 4 */,
                    ),
                  )),
                  
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Time-Zone", style: TextStyle(color: Colors.white, fontSize: 20)),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Icon(Icons.language, color: Colors.white,),
                            Text(" UTC" + offsetSign + timeZoneString, style: TextStyle(color: Colors.white, fontSize: 20)),
                          ],
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: deprecated_member_use
  FlatButton buildFlatButton(String title, String image) {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: (){}, 
      child: Column(
        children: [
          Image.asset(image, scale: 1.5,),
          SizedBox(height: 15,),
          Text(title, style: TextStyle(fontSize: 14, color: Colors.white),)
        ],
      )
    );
  }
}
