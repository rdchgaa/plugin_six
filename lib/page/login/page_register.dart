import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xxc_flutter_utils/xxc_flutter_utils.dart';
import 'package:plugin_six2/page/login/login_page/xd_register_build.dart';
import 'package:plugin_six2/util/language.dart';
import 'package:plugin_six2/widget/my_button.dart';

class _ControlPageRegister extends RouterDataNotifier {
  GlobalKey _formKey = new GlobalKey<FormState>();
  TextEditingController _unPhone = new TextEditingController();
  TextEditingController _unPassword = new TextEditingController();
  TextEditingController _unConfirmPassword = new TextEditingController();
  TextEditingController _unInvitationCode = new TextEditingController();
  bool _isLock = false;
  Timer? _timer;
  DateTime _endTime = DateTime.now().add(const Duration(seconds: 60));

  bool _isCountDown = false;
  bool passwordVisible = true;
  bool passwordComVisible = true;

  @override
  Future<void> init(BuildContext context) async {
    passwordVisible = true;
    passwordComVisible = true;
    value = true;
    // _timer = Timer.periodic(const Duration(seconds: 1), _onTimer);
  }

  void _onTimer(Timer timer) {
    var val = DateTime.now().compareTo(_endTime);
    if (1 == val) {
      _timer?.cancel();
      _timer = null;
    }
    notifyListeners();
  }

  Future<void> _onGetCode(BuildContext context) async {
    if (_isLock) {
      return;
    }
    if (_unPhone.text.length != 10) {
      showToast(context, 'Please enter the correct phone number');
      return;
    }
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), _onTimer);
    _isLock = true;
    _isCountDown = true;
    showToast(context, 'Verification code sent successfully');
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  Future<void> _onSubmit(BuildContext context) async {
    showToast(context, 'Verification code error');
    return;

  }
}

class PageRegister extends RouterDataWidget<_ControlPageRegister> {
  @override
  _PageRegisterState createState() => _PageRegisterState();

  @override
  _ControlPageRegister initData(BuildContext context) {
    return _ControlPageRegister();
  }
}

class _PageRegisterState extends RouterDataWidgetState<PageRegister> {

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: XdRegisterBuild(),
    );
  }
}
