import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'output.dart';
import 'input_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var check;
  void getCurrentPosition() async {
    check = await Geolocator.checkPermission();

    if (check == LocationPermission.denied) {
      check = Geolocator.requestPermission();

      if (check == LocationPermission.denied) {
        print('Permission denied');
      }
    }

    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    print(pos.latitude);
    print(pos.longitude);
  }

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text('First Page')),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 100,
                  width: 300,
                  color: Colors.deepOrangeAccent,
                  child: FlatButton(
                    onPressed: (() {
                      setState(() {
                        getCurrentPosition();
                      });
                    }),
                    child: Center(
                        child: Text(
                      "Present Location",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: inputPage(),
              )
            ],
          )),
    );
  }
}
