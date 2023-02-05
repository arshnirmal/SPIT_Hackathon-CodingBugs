import 'package:flutter/material.dart';  

import 'package:flutter_switch/flutter_switch.dart';

    
  

  
class SwitchScreen extends StatefulWidget {  
  @override  
  SwitchClass createState() => new SwitchClass();  
}  
  
class SwitchClass extends State {  
  bool isSwitched = false;
  
  bool status =true;  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(
      body: Column(  
          mainAxisAlignment: MainAxisAlignment.center,  
          children:<Widget>[  
             FlutterSwitch(
                activeColor: Colors.green,
                width: 125.0,
                height: 55.0,
                valueFontSize: 25.0,
                toggleSize: 45.0,
                value: status,
                borderRadius: 30.0,
                padding: 8.0,
                showOnOff: true,
                onToggle: (val) {
                  setState(() {

                    status = val;
                  });
                },
              ),
            SizedBox(height: 15.0,),  

            FlutterSwitch(
                width: 100.0,
                height: 55.0,
                toggleSize: 45.0,
                value: status,
                borderRadius: 30.0,
                padding: 2.0,
                activeToggleColor: Colors.purple,
                inactiveToggleColor: Colors.black,
                activeSwitchBorder: Border.all(
                  color: Colors.orange,
                  width: 6.0,
                ),
                inactiveSwitchBorder: Border.all(
                  color: Colors.black,
                  width: 6.0,
                ),
                activeColor: Colors.deepPurpleAccent,
                inactiveColor: Colors.white,
                activeIcon: Icon(
                  Icons.nightlight_round,
                  color: Colors.white,
                ),
                inactiveIcon: Icon(
                  Icons.wb_sunny,
                  color: Color(0xFFFFDF5D),
                ),
                onToggle: (val) {
                  setState(() {
                    status = val;
                  });
                },
              ),
            
          ]),
    );  
    }  
}  