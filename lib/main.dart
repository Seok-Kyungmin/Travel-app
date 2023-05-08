import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internship/screens/login_screen.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart'
    show KakaoSdk, User, UserApi, isKakaoTalkInstalled;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


final GlobalKey<ScaffoldMessengerState> snackbarKey =
GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  KakaoSdk.init(nativeAppKey: 'ef0f5152f3d8493fe678545585607797');
  runApp(ProviderScope(child: MyApp()));
}

enum LoginPlatform { naver, none }

LoginPlatform _loginPlatform = LoginPlatform.none;

class CandyGlobalVariable {
  static final GlobalKey<NavigatorState> naviagatorState =
  GlobalKey<NavigatorState>();
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: snackbarKey,
      navigatorKey: CandyGlobalVariable.naviagatorState,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: LoginPageState(),
    );
  }
}

