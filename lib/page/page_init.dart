import 'dart:io';

import 'package:flutter/material.dart';
import 'package:xxc_flutter_utils/xxc_flutter_utils.dart';
import 'package:plugin_six2/dialog/alert_dialog.dart';
import 'package:plugin_six2/net/network.dart';
import 'package:plugin_six2/page/home/page_home.dart';
import 'package:plugin_six2/page/login/page_login.dart';
import 'package:plugin_six2/service/preferences.dart';
import 'package:plugin_six2/service/ser_base.dart';
import 'package:plugin_six2/service/ser_user.dart';
import 'package:plugin_six2/util/language.dart';
import 'package:plugin_six2/util/navigator.dart';
import 'package:plugin_six2/widget/app_content.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class ControlInit extends RouterDataNotifier {
  // Widget _guide;
  final bool isCheckVersion;

  ControlInit({this.isCheckVersion = true});

  init(BuildContext context,{bool needLogin = true}) async {
    value = await LoadingCall.of(context).call((state, controller) async {
      var info = await PackageInfo.fromPlatform();
      try {
        // Api.deviceId = await App.of(context).getDeviceId();
        // var apiDeviceId = Api.deviceId;
        // //26b448e7fb3578b46213f8ce2fe32
        // setDeviceId(Api.deviceId);
        // var deviceId = getDeviceId();
        // // logger.i("init_page_device_id:$deviceId");
        // if (deviceId == null) {
        //   var newDeviceId = '1000';
        //   setDeviceId(newDeviceId);
        //   logger.i("init_page set devoce_id = $newDeviceId");
        // }

        var token = getToken();
        if (null == token) {
          guestLogin(context);
          return true;
        } else {
          if(needLogin){
            //登录 保存的账号密码
            var userName = getUserName();
            var password = getPassword();
            if(userName!=null&&password!=null){
              var res = await NetWork.toLogin(context,userName,password);
              if (res!=null) {
                saveLoginInfo(res);
              } else {
              }
            }
          }
        }

      } catch (e) {
        _showNetwork(context);
        return false;
      }

      await context.read<SerUser>().init();
      // try {
      //   await context.read<SerUser>().init();
      // } catch (e) {
      //   print(e);
      // }
      try {
        await context.read<SerBase>().init();
      } catch (e) {
        print(e);
      }
      setBeforeVersion(int.tryParse(info.buildNumber) ?? -1);
      await Future.delayed(Duration(milliseconds: 100),(){
      });
      // AutoRouter.of(context).pushNamedAndRemoveUntil("/home", predicate: (routerData) => true);
      PageHome().pushAndRemoveUntil(context, (route) => false);

      return true;
    }, isShowLoading: false, duration: null);
  }

  saveLoginInfo(var res){
    setToken(res['token']);
    setUserId(res['user_id']);
  }

  guestLogin(context) async{
    setToken(null);
    setUserId(null);
    goHome(context);
  }

  goHome(context) async{
    await Future.delayed(Duration(milliseconds: 1000),(){
      PageHome().pushAndRemoveUntil(context, (route) => false);
    });
  }

  void _showNetwork(BuildContext context) async {
    var value = await showAlertDialog(
      context,
      content: '服务器维护中，请稍后在试，敬请谅解',
      buttonCancel: '退出',
      buttonOk: '尝试重连',
    );
    if (true == value) {
      init(context);
    } else {
      exit(0);
    }
  }

  void gotoLoginPage(BuildContext context) {
    PageLogin().pushAndRemoveUntil(context, (router) => true);
    // AutoRouter.of(context).pushNamedAndRemoveUntil("/login_username", predicate: (routerData) => true);
    // AutoRouter.of(context).pushNamedAndRemoveUntil("/login_username", predicate: (routerData) => true);
    // if (getAppConfig().accountLogin) {
    //   AutoRouter.of(context).pushNamedAndRemoveUntil("/login_username", predicate: (routerData) => true);
    // } else if (getAppConfig().phoneLogin) {
    //   AutoRouter.of(context).pushNamedAndRemoveUntil("/login_phone", predicate: (routerData) => true);
    // }
  }
}

class PageInit extends StatefulWidget {
  final bool needLogin;
  const PageInit({Key? key, this.needLogin = true,}) : super(key: key);

  @override
  _PageInitState createState() => _PageInitState();
}

class _PageInitState extends State<PageInit> {

  ControlInit? initControl;


  @override
  void initState() {
    super.initState();
    initControl = ControlInit();
    initControl!.init(context,needLogin: widget.needLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Loading(
      child: LoadingCall(
          onInitLoading: _onInitLoading,
          emptyBuilder: (context) {
            return UiEmptyView(type: EmptyType.data);
          },
          errorBuilder: (context, error) {
            return UiEmptyView(type: EmptyType.network, onPressed: () => _onInitLoading(context));
          },
          builder: (context) {
          return Container(
            alignment: Alignment.center,
            // color: Colors.white,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/assets_six/images/home.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/assets_six/images/app_icon.png'),
                  fit: BoxFit.fill,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x33b3b3b3),
                    offset: Offset(0, 0),
                    blurRadius: 24,
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
    // return Scaffold(
    //   body: null == widget.data._guide ? Container() : widget.data._guide,
    // );
  }
  Future<bool> _onInitLoading(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 300));
    await LoadingCall.of(context).call((state, controller) async {
      return true;
    }, duration: const Duration(milliseconds: 100));

    return true;
  }

}

class ShowGuide extends StatefulWidget {
  final VoidCallback? onStrat;

  ShowGuide({
    key,
    this.onStrat,
  }) : super(key: key);

  @override
  _ShowGuideState createState() => _ShowGuideState();
}

class _ShowGuideState extends State<ShowGuide> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      Image.asset(
        'assets/imgs/page_01.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
      Image.asset(
        'assets/imgs/page_02.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
      Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset(
            'assets/imgs/page_03.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 62,
            child: SizedBox(
              width: 200,
              height: 42,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(StadiumBorder()),
                  backgroundColor: MaterialStateProperty.all(Color(0xFF21A27C)),
                ),
                onPressed: () async {
                  if (null != widget.onStrat) {
                    widget.onStrat!();
                    var info = await PackageInfo.fromPlatform();
                    setBeforeVersion(int.tryParse(info.buildNumber) ?? -1);
                  }
                },
                child: Text(
                  '立即体验',
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    // fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    ];
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        PageView(
          children: children,
          onPageChanged: (val) => setState(() => _index = val),
        ),
        Positioned(
          bottom: 40,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children.map((item) {
                return Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: children.indexOf(item) == _index ? Color(0xff81bebe) : Color(0x805aabab),
                    // border: Border.all(color: Colors.white),
                    shape: BoxShape.circle,
                  ),
                );
              }).toList()),
        ),
      ],
    );
  }
}
