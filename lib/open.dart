import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plugin_six2/app.dart';
import 'package:plugin_six2/service/preferences.dart';


openAPPSix(BuildContext context) async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  SystemChrome.setPreferredOrientations([
    // 强制竖屏
    DeviceOrientation.portraitUp
  ]);
  try {
  } catch (e) {
    print(e);
  }
  await initSharedPreferences();

  var config = AppConfig(
    logicHost: "",
    logicPort: 0,
    // fileScheme: "https",
    // fileHost: "file.k1.game/",
    fileScheme: "http",
    // fileHost: " http://192.168.6.117:12345/",//本地
    fileHost: "47.97.250.198:12345/", //阿里
    apiScheme: "http",
    // apiHost: 'http://192.168.6.117:12345/',//本地
    apiHost: 'http://47.97.250.198:12345/',//阿里
    socketHost: "",
    mode: RunMode.profile,
  );
  // Navigator.push(context, MaterialPageRoute(builder: (context) {
  //   return App(config: config);
  // },),);
  runApp(
    App(config: config),
  );
}