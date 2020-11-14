// import 'dart:html';

import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(HealthApp());
}


class HealthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Healthification', style: TextStyle(letterSpacing: 5),
            ),
          ),
        ),
        backgroundColor: Colors.white70,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: HomePage(),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt),
              label: 'Record',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.stacked_bar_chart),
              label: 'Trend',
            ),
          ],
          currentIndex: 0,
          selectedItemColor: Colors.blue[400],
          // onTap: _onItemTapped,
        ),
      ),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double _systolicValue = 120;
  double _diastolicValue = 80;
  dynamic _lastSystolicValue = '--';
  dynamic _lastDiastolicValue = '--';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 180,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: Colors.blue.shade100,
              // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                    ),
                    title: Text('Blood pressure',
                      style: TextStyle(fontSize: 20, color: Colors.blueGrey, fontFamily: 'Ubuntu'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '$_lastSystolicValue/$_lastDiastolicValue',
                          style: TextStyle(
                              color: Colors.grey.shade800, fontSize: 30),
                        ),
                        RaisedButton(
                          // onPressed: () {
                          //   _navigateToNextScreen(context);
                          // },
                          color: Colors.blue,
                          disabledColor: Colors.blue,
                          textColor: Colors.white,
                          child: const Text('Record'),
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 200,
                                  color: Colors.lightBlue[50],
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      // mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Column(
                                          children: <Widget>[
                                            const Text('Systolic (mmHg)'),
                                            Slider(
                                              value: _systolicValue,
                                              min: 1,
                                              max: 300,
                                              divisions: 299,
                                              label: '$_systolicValue',
                                              onChanged: (value) {
                                                setState(
                                                        () {
                                                      _systolicValue = value;
                                                      _lastSystolicValue = value;
                                                    });
                                              },
                                            ),
                                            const Text('Diastolic (mmHg)'),
                                            SliderTheme(
                                              data: SliderTheme.of(context).copyWith(
                                                activeTrackColor: Colors.blue[700],
                                                inactiveTrackColor: Colors.blue[100],
                                                trackShape: RoundedRectSliderTrackShape(),
                                                trackHeight: 4.0,
                                                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 14.0),
                                                thumbColor: Colors.blueAccent,
                                                overlayColor: Colors.blue.withAlpha(32),
                                                overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                                                tickMarkShape: RoundSliderTickMarkShape(),
                                                activeTickMarkColor: Colors.blue[700],
                                                inactiveTickMarkColor: Colors.blue[100],
                                                valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                                                valueIndicatorColor: Colors.blueAccent,
                                                valueIndicatorTextStyle: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              child: Slider(
                                                value: _diastolicValue,
                                                min: 0,
                                                max: 250,
                                                divisions: 250,
                                                label: _diastolicValue.round().toString(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    _diastolicValue = value;
                                                    _lastDiastolicValue = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        ElevatedButton(
                                          child:
                                          const Text('Save'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        )],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewScreen()));
  }
}


class NewScreen extends StatefulWidget {
  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historical Data'),
      ),
    );
  }
}

// RaisedButton(
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(10.0),
// side: BorderSide(color: Colors.blue.shade100)),
// onPressed: () {},
// color: Colors.blue.shade100,
// textColor: Colors.white,
// child:
// Text("Buy now".toUpperCase(), style: TextStyle(fontSize: 14)),
// ),
//