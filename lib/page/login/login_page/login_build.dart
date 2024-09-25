import 'package:adobe_xd/pinned.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plugin_six2/app.dart';
import 'package:plugin_six2/net/network.dart';
import 'package:plugin_six2/page/login/page_register.dart';
import 'package:plugin_six2/page/page_init.dart';
import 'package:plugin_six2/service/preferences.dart';
import 'package:plugin_six2/util/navigator.dart';
import 'package:plugin_six2/widget/app_content.dart';
import 'package:xxc_flutter_utils/xxc_flutter_utils.dart';

class LoginBuild extends StatefulWidget {
  LoginBuild({
    Key? key,
  }) : super(key: key);

  @override
  _LoginBuildState createState() => _LoginBuildState();
}

class _LoginBuildState extends State<LoginBuild> with SingleTickerProviderStateMixin {

  GlobalKey _formKey = new GlobalKey<FormState>();
  TextEditingController _unPhone = new TextEditingController(text: '');
  TextEditingController _unPassword = new TextEditingController(text: '');

  bool passwordVisible = true;
  bool _repeatLogin = false;

  @override
  void initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([
    //   // 强制竖屏
    //   DeviceOrientation.portraitUp
    // ]);
  }

  @override
  void dispose() {
    super.dispose();
    // SystemChrome.setPreferredOrientations([
    //   // 强制竖屏
    //   DeviceOrientation.landscapeLeft
    // ]);
  }


  visibleBuild(bool isShow){
    return Pinned.fromPins(
      Pin(size: 20.0, end: 20.0),
      Pin(size: 20.0, middle: 0.4773),
      child: Stack(
        children: <Widget>[
          !isShow?
          Pinned.fromPins(
            Pin(start: 0.8, end: 0.8),
            Pin(size: 12.4, middle: 0.5),
            child: Stack(
              children: <Widget>[
                SizedBox.expand(
                    child: SvgPicture.string(
                      _svg_op9c4z,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    )),
                Pinned.fromPins(
                  Pin(size: 8.4, middle: 0.4922),
                  Pin(start: 1.8, end: 2.1),
                  child: SvgPicture.string(
                    _svg_op9c4z,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ):
          Pinned.fromPins(
            Pin(start: 0.0, end: 0.0),
            Pin(size: 11.7, middle: 0.4844),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 0.5),
                  child: SizedBox.expand(
                      child: SvgPicture.string(
                        _svg_bs2n5,
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.fill,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 3.6, vertical: 0.0),
                  child: SizedBox.expand(
                      child:
                      // Adobe XD layer: '路径 2489' (shape)
                      SvgPicture.string(
                        _svg_yzm50,
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.fill,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _onSubmit(BuildContext context) async {
    // var login = await LoadingCall.of(context).call((state, controller) async {
    //   await Future.delayed(Duration(milliseconds: 200), () {});
    //   return true;
    // });
    if(_unPhone.text.length==''){
      showToast(context, '请输入账号');
      return;
    }
    if(_unPassword.text==''){
      showToast(context, '请输入密码');
      return;
    }
    var res = await LoadingCall.of(context).call((state, controller) async {
      return await NetWork.toLogin(context,_unPhone.text,_unPassword.text);
    },isShowLoading: true);
    // var res = await NetWork.toLogin(context,_unPhone.text,_unPassword.text);

    if (res!=null) {
      saveLoginInfo(res);
      goHome();
    } else {
      // showToast(context, Languages.of(context).accountOrPasswordError);
      showToast(context, '用户或密码错误');
    }
    return;
  }

  saveLoginInfo(var res){
    setToken(res['token']);
    setUserId(res['user_id']);
    setUserName(_unPhone.text);
    setPassword(_unPassword.text);
  }


  goHome(){
    PageInit(needLogin: false,).pushAndRemoveUntil(context, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Loading(
        child: LoadingCall(
            onInitLoading: _onInitLoading,
            emptyBuilder: (context) {
              return UiEmptyView(type: EmptyType.data);
            },
            errorBuilder: (context, error) {
              return UiEmptyView(type: EmptyType.network, onPressed: () => _onInitLoading(context));
            },
            builder: (context) {
            return DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/assets_six/images/login_back2.webp'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(0x44000000)
                    ),
                    child: SizedBox(
                      width: width,
                      height: height,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: ListView(
                      padding: EdgeInsets.only(top: 0),
                      children: [
                        SizedBox(
                          width: width,
                          height: height,
                          child: Stack(
                            children: <Widget>[
                              Pinned.fromPins(
                                Pin(start: 20.0, end: 20.0),
                                Pin(size: 56.0, middle: 0.3757),
                                child: SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: TextFormField(
                                    autofocus: true,
                                    onChanged: (val) {},
                                    controller: _unPhone,
                                    keyboardType: TextInputType.emailAddress,
                                    cursorColor: Color(0xFF21A27C),
                                    style: TextStyle(color: Color(0xFFffffff), fontSize: 18,fontWeight: FontWeight.bold),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0x33ffffff),
                                      prefix: SizedBox(width: 10,),
                                      // prefixIconConstraints: BoxConstraints(),
                                      // prefix: Text('+91 ',style: TextStyle(fontSize: 14,color: Color(0xff999999)),),
                                      hintText: '账号',
                                      hintStyle: TextStyle(color: Color(0xFFdddddd), fontSize: 16),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        borderSide: BorderSide(style: BorderStyle.none),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        borderSide: BorderSide(style: BorderStyle.none),
                                      ),
                                      // border: InputBorder.none
                                    ),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(20),
                                    ],
                                  ),
                                ),
                              ),
                              Pinned.fromPins(
                                Pin(start: 20.0, end: 20.0),
                                Pin(size: 56.0, middle: 0.4762),
                                child: SizedBox(
                                  height: 60,
                                  width: double.infinity,
                                  child: TextFormField(
                                    onChanged: (val) {
                                      // widget.data._number = val;
                                    },
                                    cursorColor: Color(0xFF21A27C),
                                    controller: _unPassword,
                                    style: TextStyle(color: Color(0xFFffffff), fontSize: 18,fontWeight: FontWeight.bold),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0x33ffffff),
                                      hintText: '密码',
                                      prefix: SizedBox(
                                        width: 10,
                                      ),
                                      hintStyle: TextStyle(color: Color(0xFFdddddd), fontSize: 16),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        borderSide: BorderSide(style: BorderStyle.none),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        borderSide: BorderSide(style: BorderStyle.none),
                                      ),
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.only(right: 0),
                                        child: SizedBox(
                                          width: 60,
                                          height: 50,
                                          child: InkWell(
                                            //根据passwordVisible状态显示不同的图标
                                            child: passwordVisible
                                                ? visibleBuild(true)
                                                : visibleBuild(false),
                                            onTap: () {
                                              //更新状态控制密码显示或隐藏
                                              setState(() {
                                                passwordVisible = !passwordVisible;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    obscureText: passwordVisible,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(20),
                                    ],
                                  ),
                                ),
                              ),

                              Pinned.fromPins(
                                Pin(size: 98.0, start: 20.0),
                                Pin(size: 46.0, middle: 0.2807),
                                child: Text(
                                  '登录',
                                  style: TextStyle(
                                    fontFamily: 'Source Han Sans CN',
                                    fontSize: 20,
                                    color: const Color(0xffffffff),
                                    fontWeight: FontWeight.w800,
                                  ),
                                  softWrap: false,
                                ),
                              ),
                              Align(
                                alignment: Alignment(0.0, 0.086),
                                child: InkWell(
                                  onTap: (){
                                    // AutoRouter.of(context).pushNamed(
                                    //   "/login_register",
                                    // );
                                    PageRegister().push(context);
                                  },
                                  child: SizedBox(
                                    width: 89.0,
                                    height: 24.0,
                                    child: Stack(
                                      alignment: Alignment.centerLeft,
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(size: 61.0, start: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child: Text(
                                            '     注册',
                                            style: TextStyle(
                                              fontFamily: 'Source Han Sans CN',
                                              fontSize: 16,
                                              color: const Color(0xffffffff),
                                              fontWeight: FontWeight.w700,
                                            ),
                                            softWrap: false,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: SizedBox(
                                            width: 20.0,
                                            height: 20.0,
                                            child: Stack(
                                              children: <Widget>[
                                                Pinned.fromPins(
                                                  Pin(start: 1.0, end: 1.1),
                                                  Pin(size: 11.3, middle: 0.5769),
                                                  child: SvgPicture.string(
                                                    _svg_dahhp4,
                                                    color: Color(0xffffffff),
                                                    allowDrawingOutsideViewBox: true,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment(0.0, 0.5),
                                child: InkWell(
                                  onTap: (){
                                    // AutoRouter.of(context).pushNamed(
                                    //   "/login_register",
                                    // );
                                    PageRegister().push(context);
                                  },
                                  child: SizedBox(
                                    height: 24.0,
                                    child: Stack(
                                      alignment: Alignment.centerLeft,
                                      children: <Widget>[
                                        Text(
                                          '',
                                          // '本产品不含任何充值交易行为',
                                          style: TextStyle(
                                            fontFamily: 'Source Han Sans CN',
                                            fontSize: 16,
                                            color: const Color(0xffffffff),
                                            fontWeight: FontWeight.w700,
                                          ),
                                          softWrap: false,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Pinned.fromPins(
                                Pin(start: 20.0, end: 20.0),
                                Pin(size: 70.0, middle: 0.6402),
                                child: InkWell(
                                  onTap: ()  async {
                                    _onSubmit(context);
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(image: AssetImage("assets/assets_six/images/ok.png"), fit: BoxFit.fill),
                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                        ),
                                        child: SizedBox(
                                          width: 150,
                                          height: 80,
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom: 8.0),
                                              // child: Text(
                                              //   '登录',
                                              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xffeeeeee)),
                                              // ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Pinned.fromPins(
                                Pin(start: 0.0, end: 0.0),
                                Pin(size: 34.0, end: 0.0),
                                child:
                                    // Adobe XD layer: 'lit' (shape)
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: const AssetImage(''),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Pinned.fromPins(
                                Pin(size: 100.0, middle: 0.5018),
                                Pin(size: 100.0, start: 84.0),
                                child: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/assets_six/images/new_logo.webp'),
                                      fit: BoxFit.fill,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xaaffffff),
                                        offset: Offset(0, 0),
                                        blurRadius: 24,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if(Navigator.canPop(context))
                              Pinned.fromPins(
                                Pin(size: 26.0, start: 20.0),
                                Pin(size: 26.0, middle: 0.07),
                                child: InkWell(
                                  onTap: () {
                                    // AutoRouter.of(context).pop();
                                    Navigator.pop(context);
                                  },
                                  child: Stack(
                                    children: <Widget>[
                                      Pinned.fromPins(
                                        Pin(start: 1.9, end: 1.4),
                                        Pin(size: 14.4, middle: 0.5864),
                                        child: SvgPicture.string(
                                          _svg_i3q6wh,
                                          allowDrawingOutsideViewBox: true,
                                          fit: BoxFit.fill,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  Future<bool> _onInitLoading(BuildContext context) async {
    return true;
  }
}

const String _svg_i02txq =
    '<svg viewBox="0.0 211.8 20.0 6.7" ><path transform="translate(-0.01, -0.1)" d="M 19.19588661193848 218.5856018066406 C 18.94002532958984 218.5856018066406 18.68806648254395 218.4645233154297 18.52790832519531 218.2398986816406 C 16.41654777526855 215.2476806640625 13.31103229522705 213.5308532714844 10.01019954681396 213.5308532714844 C 6.709366321563721 213.5308532714844 3.603850364685059 215.2476806640625 1.492489457130432 218.2398986816406 C 1.232719898223877 218.6071166992188 0.7229461669921875 218.6969451904297 0.3557530343532562 218.4371795654297 C -0.01339325960725546 218.1774139404297 -0.1012852340936661 217.6676483154297 0.1584843844175339 217.3004302978516 C 2.580397129058838 213.8687438964844 6.170295238494873 211.8999633789062 10.01019954681396 211.8999633789062 C 13.85010242462158 211.8999633789062 17.44000053405762 213.8687438964844 19.86191368103027 217.3004302978516 C 20.12168502807617 217.6695709228516 20.03379249572754 218.1774139404297 19.66464424133301 218.4371795654297 C 19.52206611633301 218.5387420654297 19.35799789428711 218.5856018066406 19.19588661193848 218.5856018066406 Z" fill="#696969" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_tpq3e =
    '<svg viewBox="0.0 211.8 20.0 11.7" ><path transform="translate(0.0, 0.0)" d="M 10.00113105773926 223.5423431396484 C 6.161228656768799 223.5423431396484 2.571329116821289 221.5735626220703 0.1494168341159821 218.1418762207031 C -0.04980498552322388 217.8606109619141 -0.04980498552322388 217.4836578369141 0.1494168341159821 217.2004547119141 C 2.571329116821289 213.7687683105469 6.161228179931641 211.7999725341797 10.00113105773926 211.7999725341797 C 13.84103488922119 211.7999725341797 17.43093299865723 213.7687683105469 19.85284614562988 217.2004547119141 C 20.05206489562988 217.4817199707031 20.05206489562988 217.8586578369141 19.85284614562988 218.1418762207031 C 17.43093490600586 221.5735626220703 13.84103488922119 223.5423431396484 10.00113105773926 223.5423431396484 Z M 1.833036541938782 217.6711578369141 C 3.92877197265625 220.3723754882812 6.878036499023438 221.9095153808594 10.00113105773926 221.9095153808594 C 13.12422466278076 221.9095153808594 16.07348823547363 220.3723754882812 18.16922569274902 217.6711578369141 C 16.07349014282227 214.9699554443359 13.12617874145508 213.4328155517578 10.00113105773926 213.4328155517578 C 6.876083374023438 213.4328155517578 3.92877197265625 214.9699554443359 1.833036065101624 217.6711578369141 Z" fill="#696969" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_qojei =
    '<svg viewBox="6.9 214.6 6.1 6.1" ><path transform="translate(-348.8, -141.48)" d="M 358.8027648925781 362.2055358886719 C 357.119140625 362.2055358886719 355.75 360.8363952636719 355.75 359.1527709960938 C 355.75 357.4691467285156 357.119140625 356.1000061035156 358.8027648925781 356.1000061035156 C 360.4863586425781 356.1000061035156 361.8555603027344 357.4691467285156 361.8555603027344 359.1527709960938 C 361.8555603027344 360.8363952636719 360.4863586425781 362.2055358886719 358.8027648925781 362.2055358886719 Z M 358.8027648925781 357.7328186035156 C 358.0195617675781 357.7328186035156 357.3828430175781 358.3695678710938 357.3828430175781 359.1527709960938 C 357.3828430175781 359.9359741210938 358.0195617675781 360.5727233886719 358.8027648925781 360.5727233886719 C 359.5859985351562 360.5727233886719 360.2227172851562 359.9359741210938 360.2227172851562 359.1527709960938 C 360.2227172851562 358.3695678710938 359.5859985351562 357.7328186035156 358.8027648925781 357.7328186035156 Z" fill="#696969" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_dahhp4 =
    '<svg viewBox="326.0 622.0 17.9 11.3" ><path transform="translate(325.99, 622.0)" d="M 11.25649738311768 11.02527141571045 C 10.82097053527832 10.61446380615234 10.82097053527832 9.945850372314453 11.25649738311768 9.534278869628906 L 14.23364353179932 6.721359252929688 L 1.115530610084534 6.721359252929688 C 0.499479204416275 6.721359252929688 0 6.249351978302002 0 5.667183399200439 C 0 5.085015773773193 0.499479204416275 4.612243175506592 1.115530610084534 4.612243175506592 L 14.23313426971436 4.612243175506592 L 11.25649738311768 1.799323201179504 C 10.82097053527832 1.388516068458557 10.82097053527832 0.719902515411377 11.25649738311768 0.3083303570747375 C 11.69202327728271 -0.1024767905473709 12.39874172210693 -0.1024767905473709 12.83426856994629 0.3083303570747375 L 17.56758308410645 4.781308650970459 C 17.82054901123047 5.020806789398193 17.92625427246094 5.347040176391602 17.88481521606445 5.659101963043213 C 17.93209838867188 5.975975513458252 17.82691955566406 6.309515953063965 17.56920051574707 6.55305814743042 L 12.83426856994629 11.02527141571045 C 12.61650562286377 11.23105716705322 12.3309440612793 11.33395004272461 12.04538249969482 11.33395004272461 C 11.75982189178467 11.33395004272461 11.4742603302002 11.23105716705322 11.25649738311768 11.02527141571045 Z" fill="#0e0f0f" stroke="#0e0f0f" stroke-width="0.20000000298023224" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_op9c4z =
    '<svg viewBox="26.9 192.0 18.4 12.4" ><path transform="translate(0.0, 0.0)" d="M 44.77887725830078 196.9345703125 C 41.92770385742188 193.6627502441406 39.02892303466797 192 36.083740234375 192 C 33.1385498046875 192 30.23976707458496 193.6627502441406 27.38859748840332 196.9345703125 C 26.70829582214355 197.7152099609375 26.69527244567871 198.874267578125 27.35786247253418 199.6700134277344 C 29.96133995056152 202.7960205078125 32.87760162353516 204.3828125 36.083740234375 204.3828125 C 39.28987121582031 204.3828125 42.20613861083984 202.7960205078125 44.80960845947266 199.6700134277344 C 45.47219848632812 198.874267578125 45.45917510986328 197.7152099609375 44.77887725830078 196.9345703125 Z M 43.88332366943359 198.8992309570312 C 41.49439239501953 201.7678527832031 38.90236663818359 203.1781005859375 36.083740234375 203.1781005859375 C 33.26510620117188 203.1781005859375 30.6730785369873 201.7678527832031 28.28414344787598 198.8992309570312 C 28.00030326843262 198.5581970214844 28.00591850280762 198.0615844726562 28.29739952087402 197.72705078125 C 30.94005393981934 194.6944885253906 33.53509521484375 193.205322265625 36.083740234375 193.205322265625 C 38.63236999511719 193.205322265625 41.22801971435547 194.6944885253906 43.87006378173828 197.7264404296875 C 44.16175079345703 198.0615234375 44.16717529296875 198.55810546875 43.88332366943359 198.8992309570312 Z" fill="#0e0f0f" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_lhj0xo =
    '<svg viewBox="31.8 193.8 8.4 8.4" ><path transform="translate(-256.21, -94.19)" d="M 292.2186279296875 288 C 289.8887634277344 288 288 289.8887634277344 288 292.2186279296875 C 288 294.5484924316406 289.8887634277344 296.4371948242188 292.2186279296875 296.4371948242188 C 294.5484924316406 296.4371948242188 296.4371948242188 294.5484924316406 296.4371948242188 292.2186279296875 C 296.4371948242188 289.8887634277344 294.5484924316406 288 292.2186279296875 288 Z M 291.0132751464844 292.2186279296875 C 290.3474426269531 292.2184753417969 289.8078308105469 291.6785583496094 289.8079833984375 291.0126953125 C 289.8081665039062 290.3468627929688 290.3480834960938 289.8072204589844 291.013916015625 289.807373046875 C 291.6797790527344 289.8075866699219 292.2193603515625 290.3474426269531 292.2192077636719 291.0132751464844 C 292.2190551757812 291.6791381835938 291.6791381835938 292.2187805175781 291.0132751464844 292.2186279296875 Z" fill="#0e0f0f" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_o1mex8 =
    '<svg viewBox="20.0 462.5 14.0 14.0" ><path transform="translate(20.0, 580.0)" d="M 7.000100135803223 -103.5002059936523 C 3.140232086181641 -103.5002059936523 1.358032193365943e-07 -106.6404418945312 1.358032193365943e-07 -110.5003051757812 C 1.358032193365943e-07 -114.3601760864258 3.140232086181641 -117.5004043579102 7.000100135803223 -117.5004043579102 C 10.8599681854248 -117.5004043579102 14.00020027160645 -114.3601760864258 14.00020027160645 -110.5003051757812 C 14.00020027160645 -106.6404418945312 10.8599681854248 -103.5002059936523 7.000100135803223 -103.5002059936523 Z M 7.000100135803223 -107.4778747558594 C 6.524186611175537 -107.4778747558594 6.136998176574707 -107.09033203125 6.136998176574707 -106.6139755249023 C 6.136998176574707 -106.1380615234375 6.524186611175537 -105.7508850097656 7.000100135803223 -105.7508850097656 C 7.47645092010498 -105.7508850097656 7.863988876342773 -106.1380615234375 7.863988876342773 -106.6139755249023 C 7.863988876342773 -107.09033203125 7.47645092010498 -107.4778747558594 7.000100135803223 -107.4778747558594 Z M 7.000100135803223 -115.2489318847656 C 6.614005565643311 -115.2489318847656 6.251194953918457 -115.0790176391602 6.004698276519775 -114.7827453613281 C 5.757729053497314 -114.4860610961914 5.656413078308105 -114.0979995727539 5.726710319519043 -113.7180328369141 L 6.136998176574707 -109.2048645019531 C 6.136998176574707 -108.7970275878906 6.506109237670898 -108.3409805297852 7.000100135803223 -108.3409805297852 C 7.494537353515625 -108.3409805297852 7.863988876342773 -108.7970733642578 7.863988876342773 -109.2048645019531 L 8.273489952087402 -113.7180328369141 C 8.34357738494873 -114.0968475341797 8.242251396179199 -114.4845886230469 7.995501518249512 -114.7819519042969 C 7.747806072235107 -115.078727722168 7.384995937347412 -115.2489318847656 7.000100135803223 -115.2489318847656 Z" fill="#383838" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_wt315 =
    '<svg viewBox="14.1 39.1 71.9 21.9" ><path transform="translate(25.62, 46.27)" d="M -11.54500293731689 14.52964878082275 L -11.54500293731689 -6.998579025268555 L -8.394878387451172 -6.998579025268555 L -8.394878387451172 2.223484039306641 L -4.503549575805664 2.223484039306641 L -4.503549575805664 -6.998579025268555 L -1.353429436683655 -6.998579025268555 L -1.353429436683655 14.52964878082275 L -4.503549575805664 14.52964878082275 L -4.503549575805664 4.94474983215332 L -8.394878387451172 4.94474983215332 L -8.394878387451172 14.52964878082275 L -11.54500293731689 14.52964878082275 Z M 7.973401069641113 7.00081729888916 L 6.429224014282227 -0.8001440167427063 L 6.367457389831543 -0.8001440167427063 L 4.823280334472656 7.00081729888916 L 7.973401069641113 7.00081729888916 Z M 0.1907486915588379 14.52964878082275 L 5.101235389709473 -6.998579025268555 L 7.726335525512695 -6.998579025268555 L 12.63681697845459 14.52964878082275 L 9.486696243286133 14.52964878082275 L 8.560189247131348 9.903500556945801 L 4.267376899719238 9.903500556945801 L 3.34087061882019 14.52964878082275 L 0.1907486915588379 14.52964878082275 Z M 14.18099498748779 14.52964878082275 L 14.18099498748779 -6.998579025268555 L 18.78264427185059 -6.998579025268555 C 19.79150199890137 -6.998579025268555 20.65109634399414 -6.847398281097412 21.36142158508301 -6.545035362243652 C 22.07174110412598 -6.242672443389893 22.65338134765625 -5.839521884918213 23.10633850097656 -5.335585594177246 C 23.55929565429688 -4.831646919250488 23.88357162475586 -4.25211763381958 24.07917404174805 -3.596999168395996 C 24.27476501464844 -2.941878318786621 24.37256622314453 -2.261563539505005 24.37256622314453 -1.556050300598145 L 24.37256622314453 -0.7699065804481506 C 24.37256622314453 -0.185339093208313 24.32624244689941 0.3085203170776367 24.23359107971191 0.7116714715957642 C 24.14093780517578 1.114822030067444 24.00196075439453 1.467579245567322 23.8166618347168 1.769940495491028 C 23.46664619445801 2.334351539611816 22.93133163452148 2.818130016326904 22.21071624755859 3.221280574798584 C 22.9519214630127 3.563959121704102 23.49753189086914 4.067897796630859 23.84754371643066 4.733095169067383 C 24.19755744934082 5.398294925689697 24.37256622314453 6.305381774902344 24.37256622314453 7.454360961914062 L 24.37256622314453 8.663810729980469 C 24.37256622314453 10.55862045288086 23.9041633605957 12.00995922088623 22.96736335754395 13.01783561706543 C 22.03056144714355 14.025710105896 20.5327091217041 14.52964878082275 18.47380638122559 14.52964878082275 L 14.18099498748779 14.52964878082275 Z M 17.33111763000488 4.551677227020264 L 17.33111763000488 11.44554996490479 L 18.68999099731445 11.44554996490479 C 19.32825088500977 11.44554996490479 19.82753753662109 11.3548412322998 20.18784332275391 11.17342185974121 C 20.54815101623535 10.99200439453125 20.82095527648926 10.74003601074219 21.00625801086426 10.41751384735107 C 21.19156074523926 10.09499549865723 21.3047981262207 9.712000846862793 21.34597778320312 9.268537521362305 C 21.38715553283691 8.825072288513184 21.40774726867676 8.341291427612305 21.40774726867676 7.817193984985352 C 21.40774726867676 7.272942543029785 21.37685966491699 6.799241065979004 21.31509399414062 6.396090507507324 C 21.25333023071289 5.992939949035645 21.12979316711426 5.65026330947876 20.94449234008789 5.368058204650879 C 20.73859786987305 5.085850238800049 20.46064758300781 4.879237651824951 20.11063575744629 4.748212814331055 C 19.7606201171875 4.617189407348633 19.29736518859863 4.551677227020264 18.72087860107422 4.551677227020264 L 17.33111763000488 4.551677227020264 Z M 17.33111763000488 -4.095895767211914 L 17.33111763000488 1.830414175987244 L 18.75175666809082 1.830414175987244 C 19.80180168151855 1.830414175987244 20.50697326660156 1.573405623435974 20.86728286743164 1.059388756752014 C 21.22759437561035 0.5453709363937378 21.40774726867676 -0.2054965496063232 21.40774726867676 -1.193214058876038 C 21.40774726867676 -2.160775184631348 21.20700263977051 -2.886446475982666 20.80551338195801 -3.370226860046387 C 20.40403175354004 -3.854006290435791 19.67826461791992 -4.095895767211914 18.62822532653809 -4.095895767211914 L 17.33111763000488 -4.095895767211914 Z M 27.33738327026367 14.52964878082275 L 27.33738327026367 -6.998579025268555 L 36.72598266601562 -6.998579025268555 L 36.72598266601562 -4.095895767211914 L 30.48750686645508 -4.095895767211914 L 30.48750686645508 2.223484039306641 L 35.92300796508789 2.223484039306641 L 35.92300796508789 5.126167297363281 L 30.48750686645508 5.126167297363281 L 30.48750686645508 11.44554996490479 L 36.72598266601562 11.44554996490479 L 36.72598266601562 14.52964878082275 L 27.33738327026367 14.52964878082275 Z M 38.76429748535156 14.52964878082275 L 38.76429748535156 -6.998579025268555 L 48.15289688110352 -6.998579025268555 L 48.15289688110352 -4.095895767211914 L 41.91442108154297 -4.095895767211914 L 41.91442108154297 2.223484039306641 L 47.34992980957031 2.223484039306641 L 47.34992980957031 5.126167297363281 L 41.91442108154297 5.126167297363281 L 41.91442108154297 11.44554996490479 L 48.15289688110352 11.44554996490479 L 48.15289688110352 14.52964878082275 L 38.76429748535156 14.52964878082275 Z M 60.38277435302734 -0.8001440167427063 L 57.23265075683594 -0.8001440167427063 L 57.23265075683594 -1.495576858520508 C 57.23265075683594 -2.201090335845947 57.06279754638672 -2.810855150222778 56.72307968139648 -3.324871063232422 C 56.38336181640625 -3.838887214660645 55.81201171875 -4.095895767211914 55.0090446472168 -4.095895767211914 C 54.57666778564453 -4.095895767211914 54.22665786743164 -4.015265941619873 53.95900344848633 -3.854006290435791 C 53.69134140014648 -3.692745685577393 53.47515106201172 -3.491172313690186 53.31044769287109 -3.249281883239746 C 53.14572906494141 -2.987234115600586 53.03248596191406 -2.689909934997559 52.97072219848633 -2.357312202453613 C 52.90895843505859 -2.02471137046814 52.87807464599609 -1.676995754241943 52.87807464599609 -1.314159154891968 C 52.87807464599609 -0.8908519744873047 52.89352035522461 -0.5380961298942566 52.92440414428711 -0.2558892965316772 C 52.95528793334961 0.02631497383117676 53.03248596191406 0.278283953666687 53.15602493286133 0.5000170469284058 C 53.27956390380859 0.7217503786087036 53.45971298217773 0.9132453203201294 53.69648742675781 1.074506402015686 C 53.93325042724609 1.235765814781189 54.25753784179688 1.397026181221008 54.66931915283203 1.558287262916565 L 57.07823181152344 2.495611667633057 C 57.77826309204102 2.757659912109375 58.34445953369141 3.065061092376709 58.77682876586914 3.417816162109375 C 59.20920562744141 3.770573616027832 59.54892349243164 4.178762912750244 59.79598999023438 4.642386436462402 C 60.02246856689453 5.126167297363281 60.17688369750977 5.675459384918213 60.25924682617188 6.290262699127197 C 60.34160232543945 6.905067443847656 60.38277435302734 7.60554027557373 60.38277435302734 8.391684532165527 C 60.38277435302734 9.298772811889648 60.29012298583984 10.14034938812256 60.10482406616211 10.91641330718994 C 59.91952133178711 11.69247722625732 59.6209831237793 12.35263824462891 59.20920181274414 12.89688873291016 C 58.77682876586914 13.46130180358887 58.21063232421875 13.90476512908936 57.51060104370117 14.22728633880615 C 56.81058502197266 14.54980564117432 55.95613861083984 14.71106815338135 54.94726943969727 14.71106815338135 C 54.18547821044922 14.71106815338135 53.47515106201172 14.58004093170166 52.81630706787109 14.31799411773682 C 52.15745162963867 14.05594825744629 51.59126281738281 13.69311237335205 51.11771011352539 13.22949123382568 C 50.64417266845703 12.76586437225342 50.26841354370117 12.22665214538574 49.99047088623047 11.61184787750244 C 49.71250915527344 10.99704170227051 49.57353210449219 10.32680702209473 49.57353210449219 9.601136207580566 L 49.57353210449219 8.452157020568848 L 52.72366333007812 8.452157020568848 L 52.72366333007812 9.419716835021973 C 52.72366333007812 9.984128952026367 52.89352035522461 10.49310684204102 53.23324584960938 10.94664859771729 C 53.57294464111328 11.40019512176514 54.14430999755859 11.62696361541748 54.94726943969727 11.62696361541748 C 55.48258972167969 11.62696361541748 55.89951324462891 11.55137538909912 56.19805908203125 11.40019512176514 C 56.49659729003906 11.24901294708252 56.72822952270508 11.03231906890869 56.89294052124023 10.75011348724365 C 57.05764389038086 10.46790885925293 57.15544509887695 10.13027095794678 57.18632507324219 9.737200736999512 C 57.21721267700195 9.344127655029297 57.23265075683594 8.905701637268066 57.23265075683594 8.421921730041504 C 57.23265075683594 7.857509613037109 57.21205902099609 7.393887519836426 57.17088317871094 7.031052589416504 C 57.12970352172852 6.668214797973633 57.04734802246094 6.375932693481445 56.92382431030273 6.154201030731201 C 56.77970123291016 5.932467937469482 56.58924102783203 5.751050472259521 56.35247421264648 5.609947204589844 C 56.11569595336914 5.468844413757324 55.80171585083008 5.317663669586182 55.41052627563477 5.1564040184021 L 53.15602493286133 4.24931526184082 C 51.79714584350586 3.705061435699463 50.88608169555664 2.98443078994751 50.42282867431641 2.087420463562012 C 49.95957946777344 1.190411448478699 49.72795486450195 0.06662988662719727 49.72795486450195 -1.283923506736755 C 49.72795486450195 -2.090224981307983 49.84119415283203 -2.856209278106689 50.06766510009766 -3.581880569458008 C 50.29414367675781 -4.307551860809326 50.63387680053711 -4.932433128356934 51.08682632446289 -5.456529140472412 C 51.51919555664062 -5.980624675750732 52.06995391845703 -6.3988938331604 52.73910903930664 -6.71133279800415 C 53.40824890136719 -7.023775577545166 54.20605850219727 -7.179996490478516 55.13257598876953 -7.179996490478516 C 55.91495895385742 -7.179996490478516 56.63042449951172 -7.038893699645996 57.27898025512695 -6.756688594818115 C 57.92753982543945 -6.474483013153076 58.48858261108398 -6.101570129394531 58.96213531494141 -5.637946605682373 C 59.90922546386719 -4.670384883880615 60.38277435302734 -3.561722755432129 60.38277435302734 -2.31195592880249 L 60.38277435302734 -0.8001440167427063 Z" fill="#ffffff" stroke="none" stroke-width="0.800000011920929" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_bs2n5 =
    '<svg viewBox="0.0 211.8 20.0 11.7" ><path transform="translate(9798.0, -1136.8)" d="M -9787.998046875 1360.3408203125 C -9788.712890625 1360.3408203125 -9789.4306640625 1360.271728515625 -9790.1318359375 1360.135498046875 L -9788.6796875 1358.683471679688 C -9788.453125 1358.69970703125 -9788.224609375 1358.708129882812 -9787.998046875 1358.708129882812 C -9786.4462890625 1358.708129882812 -9784.9423828125 1358.3359375 -9783.529296875 1357.601928710938 C -9782.1201171875 1356.869140625 -9780.8759765625 1355.815063476562 -9779.83203125 1354.468872070312 C -9780.51953125 1353.58251953125 -9781.3076171875 1352.8115234375 -9782.1748046875 1352.178344726562 L -9781.0068359375 1351.010375976562 C -9779.9287109375 1351.83203125 -9778.966796875 1352.837646484375 -9778.1474609375 1353.999145507812 C -9777.94921875 1354.27880859375 -9777.94921875 1354.65625 -9778.1474609375 1354.9384765625 C -9780.5703125 1358.371704101562 -9784.1611328125 1360.3408203125 -9787.998046875 1360.3408203125 Z M -9794.994140625 1357.926391601562 L -9794.9951171875 1357.925903320312 C -9796.0693359375 1357.106079101562 -9797.03125 1356.100952148438 -9797.8515625 1354.9384765625 C -9798.0498046875 1354.658813476562 -9798.0498046875 1354.281372070312 -9797.8515625 1353.999145507812 C -9795.4296875 1350.56591796875 -9791.837890625 1348.596801757812 -9787.998046875 1348.596801757812 C -9787.283203125 1348.596801757812 -9786.56640625 1348.665893554688 -9785.8662109375 1348.802124023438 L -9787.3193359375 1350.254150390625 C -9787.544921875 1350.237915039062 -9787.7724609375 1350.2294921875 -9787.998046875 1350.2294921875 C -9789.5517578125 1350.2294921875 -9791.056640625 1350.60205078125 -9792.4697265625 1351.336669921875 C -9793.87890625 1352.069213867188 -9795.123046875 1353.123046875 -9796.1669921875 1354.468872070312 C -9795.4814453125 1355.354248046875 -9794.693359375 1356.125122070312 -9793.826171875 1356.7587890625 L -9794.9931640625 1357.92578125 L -9794.994140625 1357.926391601562 Z" fill="#696969" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_yzm50 =
    '<svg viewBox="3.6 211.3 12.8 12.8" ><path transform="translate(1.13, 0.33)" d="M 3.739858150482178 223.7471771240234 L 2.467068195343018 222.4743804931641 L 14.00617790222168 210.9352569580078 L 15.27897834777832 212.2080535888672 L 3.739858150482178 223.7471771240234 Z" fill="#696969" stroke="none" stroke-width="1.7999999523162842" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_i3q6wh =
    '<svg viewBox="1.5 6.4 22.8 14.4" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 24.26, 20.86)" d="M 14.31960105895996 0.3926757872104645 C 13.76555919647217 0.9152726531028748 13.76555919647217 1.765827536582947 14.31960105895996 2.289395809173584 L 18.10688209533691 5.867764472961426 L 1.419087290763855 5.867764472961426 C 0.6353968381881714 5.867764472961426 0 6.468213558197021 0 7.208800792694092 C 0 7.949387073516846 0.6353968381881714 8.550809860229492 1.419087290763855 8.550809860229492 L 18.10623741149902 8.550809860229492 L 14.31960105895996 12.12917709350586 C 13.76555919647217 12.65177249908447 13.76555919647217 13.50232887268066 14.31960105895996 14.02589893341064 C 14.87364101409912 14.54849433898926 15.77267074584961 14.54849433898926 16.32671356201172 14.02589893341064 L 22.34805107116699 8.335739135742188 C 22.66985321044922 8.031068801879883 22.80432319641113 7.616061210632324 22.75160980224609 7.219081401824951 C 22.81175804138184 6.815980911254883 22.67795753479004 6.391677379608154 22.3501091003418 6.081862926483154 L 16.32671356201172 0.3926757872104645 C 16.0496940612793 0.1308923959732056 15.68642425537109 0 15.32315635681152 0 C 14.95989036560059 0 14.59662055969238 0.1308923959732056 14.31960105895996 0.3926757872104645 Z" fill="#0e0f0f" stroke="#0e0f0f" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
