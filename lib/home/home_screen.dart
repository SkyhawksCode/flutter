// import 'dart:io';

import 'dart:io';
import 'package:trade_inn/localization/language/languages.dart';
import 'package:trade_inn/utility/shared_preference_utils.dart';
import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/enums/charging_status.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_mac/get_mac.dart';
import 'package:trade_inn/components/button_widget.dart';
import 'package:trade_inn/utility/colors.dart';
import 'package:trade_inn/utility/constants.dart';
import 'package:trade_inn/utility/utils.dart';
import 'package:wifi_info_plugin/wifi_info_plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';




class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({Key key, @required this.userName}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  WifiInfoWrapper _wifiObject;
  String _platformVersion = 'Unknown';


  String _chargingStatus = 'unknown';


  @override
  void initState() {
    super.initState();
    initPlatformState();
    iterater();
  }
  
  var test;
  var name;
  var password;
  var email;  
  var macaddr;
  var itertime = 10;
    // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    WifiInfoWrapper wifiObject;
    String platformVersion;
    
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      wifiObject = await WifiInfoPlugin.wifiDetails;
    } on PlatformException {}
    if (!mounted) return;

    setState(() {
      _wifiObject = wifiObject;
    });

    try {
      platformVersion = await GetMac.macAddress;
    } on PlatformException {
      platformVersion = 'Failed to get Device MAC Address.';
    }
    
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Widget _getChargeTime(AndroidBatteryInfo data) {
    if (data.chargingStatus == ChargingStatus.Charging) {
      return data.chargeTimeRemaining == -1
          ? Text("Calculating charge time remaining")
          : Text(
              "Charge time remaining: ${(data.chargeTimeRemaining / 1000 / 60).truncate()} minutes");
    }
    return Text("Battery is full or not connected to a power source");
  }
  
  Future<String> _getId() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    var build = await deviceInfoPlugin.androidInfo;
    String deviceName = build.model;
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return deviceName; // unique ID on iOS
    } else {
      return null; // unique ID on Android
    }
  }

  Future<dynamic> sendData() async {
    var battery = (await BatteryInfoPlugin().iosBatteryInfo).batteryLevel;
    var macaddr = await GetMac.macAddress;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo;
    androidDeviceInfo = await deviceInfo.androidInfo;
    _chargingStatus=(await BatteryInfoPlugin().androidBatteryInfo).chargingStatus.toString();
    
    var body = {
      'batterylevel': battery,
      'wifimac': macaddr,
      'pdaname': androidDeviceInfo.model,
      'username': PreferenceUtils.getString(Constants.USER_NAME),
      'chargestatus': _chargingStatus.split('.')[1],
    };
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http.post(
      'http://bsbdata.myqnapcloud.com/api/store', body: json.encode(body) , headers: headers 
    );
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future<dynamic> getSetting() async {
    var body = {
      
    };
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http.post(
      'http://bsbdata.myqnapcloud.com/api/setting', body: json.encode(body) , headers: headers 
    );
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  void iterater(){
    
    Timer.periodic(Duration(seconds: itertime*60), (timer) async {
      sendData();
      getSetting().then((response){
          if(response['interval'] != 0){
            itertime = response['interval'];
          }else{
            itertime = 10;
          }
        }
      );
      
    });
  }
  @override
  Widget build(BuildContext context) {
    String ipAddress =
        _wifiObject != null ? _wifiObject.ipAddress.toString() : "ip";
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// For logo
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/logo.jpeg',
                  height: 80,
                ),
              ),
            ),
            //For sign in Text
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                Languages.of(context).labelLogindAs + ' : ${PreferenceUtils.getString(Constants.USER_NAME)}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
            StreamBuilder<AndroidBatteryInfo>(
              stream: BatteryInfoPlugin().androidBatteryInfoStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text("Voltage: ${(snapshot.data.voltage)} mV"),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          "Charging status: ${(snapshot.data.chargingStatus.toString().split(".")[1])}"),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          "Battery Level: ${(snapshot.data.batteryLevel)} %"),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Technology: ${(snapshot.data.technology)} "),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          "Battery present: ${snapshot.data.present ? "Yes" : "False"} "),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Scale: ${(snapshot.data.scale)} "),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          "Remaining energy: ${-(snapshot.data.remainingEnergy * 1.0E-9)} Watt-hours,"),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                }
                return CircularProgressIndicator();
              }),
              
            // Text('Running on:' + ipAddress),
            // Text('MAC Address : $_platformVersion\n'),
            // Text("$test"),
            ///Button for Log Out
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ButtonWidget(
                      buttonColor: AppColors.colorBlue,
                      borderColor: AppColors.colorBlue,
                      buttonName: Languages.of(context).labelLogOut,
                      onPressed: () {
                        Utils.showConfirmationAlert(context,
                            text: Languages.of(context).labelMessage,
                            okayButtonText: Languages.of(context).labelLogOut,
                            cancelButtonText: Languages.of(context).labelCancel,
                            title: Languages.of(context).labelLogOut, callbackOKay: () {
                            exit(0);
                        }, callbackCancel: () {
                          Navigator.of(context).pop();
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

