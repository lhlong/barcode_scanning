import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:provider/provider.dart';
import 'package:barcode_scanning/models/qrcodes.dart';


void main() {
  debugPaintSizeEnabled = false;
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyApp());
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? qr;
  bool camState = false;
  List<String?> qrCodesList = [];

  Icon fab = Icon(
    Icons.camera,
  );
  Color icon_color = Colors.red;
  int fabIconNumber = 0;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var qrCodesList = Provider.of<QRCodes>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scanning'),
      ),
      body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: camState
                        ? Center(
                      child: SizedBox(
                        width: 300.0,
                        height: 200.0,
                        child: QrCamera(
                          onError: (context, error) => Text(
                            error.toString(),
                            style: TextStyle(color: Colors.red),
                          ),
                          qrCodeCallback: (code) {
                            setState(() {
                              qr = code;
                              qrCodesList.add(code);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  color: Colors.white,
                                  width: 5.0,
                                  style: BorderStyle.solid),
                            ),
                          ),
                        ),
                      ),
                    )
                        : Center(child: Text("Scanning Now!"))),
                Container(
                  height: 50,
                  child: Text(
                    "QRcode: $qr",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.lightGreenAccent,
                    ),
                  ),
                ),
                Container(
                  height: 250,
                  child: ListView.builder(
                      // reverse: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: qrCodesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 15,
                          // color: Colors.lightBlue[50],
                          child:
                          // Center(child: Text('${qrCodesList[index]}')),
                          ListTile(
                            title: Text(
                              '${index} - ${qrCodesList[index]}',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.deepPurple,
                              ),
                            ),
                            trailing: Icon(
                              Icons.done_all,
                              color: Colors.green,
                            ),
                          ),
                        );
                      },
                  ),
                ),
              ],
            ),
          ),

      floatingActionButton: FloatingActionButton(
          child: fab,
          backgroundColor: icon_color,
          onPressed: () {
            setState(() {
              camState = !camState;
              if (fabIconNumber == 0) {
                fab = Icon(Icons.stop);
                fabIconNumber = 1;
                }
              else {
                fab = Icon(Icons.camera);
                fabIconNumber = 0;
              }
            });
          }),
    );
  }
}