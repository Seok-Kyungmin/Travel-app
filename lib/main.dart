import 'package:flutter/material.dart';
import 'package:internship/screens/login_screen.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart'
    show KakaoSdk, User, UserApi, isKakaoTalkInstalled;
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'firebase_options.dart';
import 'package:flutter_login/flutter_login.dart';


final GlobalKey<ScaffoldMessengerState> snackbarKey =
GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  KakaoSdk.init(nativeAppKey: 'ef0f5152f3d8493fe678545585607797');
  runApp(MyApp());
}

enum LoginPlatform { naver, none }

LoginPlatform _loginPlatform = LoginPlatform.none;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: snackbarKey,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}

// 회원 가입 페이지
class SecondPage extends StatefulWidget {
  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  bool _isChecked = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  bool isSignupScreen = true;
  final _authentication = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String userName = '';
  String userEmail = '';
  String userPassword = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  void _login_kakao() async {
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

  bool isLogin = false;
  String? accesToken;
  String? expiresAt;
  String? tokenType;
  String? name;
  String? refreshToken;

  /// Show [error] content in a ScaffoldMessenger snackbar
  void _showSnackError(String error) {
    snackbarKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(error.toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TextEditingController controller_name = TextEditingController();

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 유저 이름 입력폼
                  Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: TextFormField(
                        key: ValueKey(1),
                        controller: _nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "이름을 입력하세요";
                          }
                          if (value.length < 2) {
                            return '2자 이상 입력해주세요';
                          }
                          return null;
                        },
                        // onSaved: (value){
                        //   setState(() {
                        //     userName = value!;
                        //   });
                        // },
                        onChanged: (String value) {
                          setState(() {
                            userName = value;

                            print(userName);
                          });
                        },
                        decoration: const InputDecoration(
                            prefixIcon:
                                Icon(Icons.perm_identity, color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFD6D6D6), width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFD6D6D6), width: 2.0),
                            ),
                            hintText: '이름(필수)',
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.all(10)),
                      )),

                  // 메일 입력폼
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: _emailController,
                        key: ValueKey(2),
                        validator: (value) {
                          if (value == "") {
                            return "이메일을 입력하세요";
                          } else if (!RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(value!)) {
                            return '잘못된 이메일 형식입니다.';
                          }
                        },
                        onChanged: (value) {
                          userEmail = value!;
                        },
                        decoration: const InputDecoration(
                            prefixIcon:
                                Icon(Icons.email_outlined, color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFD6D6D6), width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFD6D6D6), width: 2.0),
                            ),
                            hintText: 'Email(필수)',
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.all(10)),
                      )),

                  // 비밀번호 입력폼
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: _pwController,
                        key: ValueKey(3),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "비밀번호를 입력하세요.";
                          }
                          if (value.length > 12) {
                            return '12자 이하로 입력해주세요.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          userPassword = value!;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                            prefixIcon:
                                Icon(Icons.lock_outline, color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFD6D6D6), width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFD6D6D6), width: 2.0),
                            ),
                            hintText: '비밀번호 12자리 이하 입력',
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.all(10)),
                      )),

                  // 비밀번호 재입력폼
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        key: ValueKey(4),
                        validator: (String? value) {
                          if (value == _pwController.text) {
                            return null;
                          } else {
                            return '비밀번호를 다시 입력하세요.';
                          }
                        },
                        onSaved: (value) {
                          userPassword = value!;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                            prefixIcon:
                                Icon(Icons.lock_outline, color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFD6D6D6), width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFD6D6D6), width: 2.0),
                            ),
                            hintText: '비밀번호',
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.all(10)),
                      )),

                  // 이용약간 동의 체크박스
                  Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Row(children: <Widget>[
                        SizedBox(
                            height: 25,
                            child: Checkbox(
                                value: _isChecked,
                                activeColor: Colors.black,
                                onChanged: (value) {
                                  setState(() {
                                    _isChecked = value!;
                                  });
                                })),
                        Text('이용약간 동의 보기',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                      ])),

                  // 개인정보수집·이용 동의 체크박스
                  Row(children: <Widget>[
                    SizedBox(
                        height: 25,
                        child: Checkbox(
                            value: _isChecked2,
                            activeColor: Colors.black,
                            onChanged: (value) {
                              setState(() {
                                _isChecked2 = value!;
                              });
                            })),
                    Text('개인정보수집·이용 동의 보기',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13)),
                  ]),

                  // 만 14세 이상 체크박스
                  Row(children: <Widget>[
                    SizedBox(
                      height: 25,
                      child: Checkbox(
                          value: _isChecked3,
                          activeColor: Colors.black,
                          onChanged: (value) {
                            setState(() {
                              _isChecked3 = value!;
                            });
                          }),
                    ),
                    Text('만 14세 이상입니다.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13)),
                  ]),

                  // 회원가입 버튼
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: GestureDetector(
                      child: SizedBox(
                        height: 45,
                        width: 370,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (isSignupScreen) {
                              _tryValidation();

                              try {
                                final newUser = await _authentication
                                    .createUserWithEmailAndPassword(
                                  email: userEmail,
                                  password: userPassword,
                                );

                                if (newUser.user != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                  );
                                }
                              } catch (e) {
                                print(e);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('이메일과 비밀번호를 확인해주세요'),
                                    backgroundColor: Colors.blue,
                                  ),
                                );
                              }
                            }
                          },
                          child: Text('회원가입'),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // -OR-
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: SizedBox(
                        width: 100,
                        child: Row(children: const <Widget>[
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "OR",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Expanded(child: Divider()),
                        ])),
                  ),

                  // Kakao Login Button
                  Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: SizedBox(
                      height: 45,
                      width: 370,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (await isKakaoTalkInstalled()) {
                            try {
                              await UserApi.instance.loginWithKakaoTalk();
                              print('카카오톡으로 로그인 성공');
                              _login_kakao();
                            } catch (error) {
                              print('카카오톡으로 로그인 실패 $error');

                              // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                              try {
                                await UserApi.instance.loginWithKakaoAccount();
                                print('카카오계정으로 로그인 성공');
                                _login_kakao();
                              } catch (error) {
                                print('카카오계정으로 로그인 실패 $error');
                              }
                            }
                          } else {
                            try {
                              await UserApi.instance.loginWithKakaoAccount();
                              print('카카오계정으로 로그인 성공');
                              _login_kakao();
                            } catch (error) {
                              print('카카오계정으로 로그인 실패 $error');
                            }
                          }
                        },
                        child: Text('카카오 로그인'),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Color(0xFFF5F5F5),
                          foregroundColor: Colors.black87,
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Naver login Button
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: 45,
                      width: 370,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            final NaverLoginResult res = await FlutterNaverLogin.logIn();
                            setState(() {
                              name = res.account.nickname;
                              isLogin = true;
                            });
                          } catch (error) {
                            _showSnackError(error.toString());
                          }

                          try {
                            final NaverAccessToken res = await FlutterNaverLogin.currentAccessToken;
                            setState(() {
                              refreshToken = res.refreshToken;
                              accesToken = res.accessToken;
                              tokenType = res.tokenType;
                            });
                          } catch (error) {
                            _showSnackError(error.toString());
                          }
                        },
                        child: Text('네이버 로그인'),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Color(0xFFF5F5F5),
                          foregroundColor: Colors.black87,
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
