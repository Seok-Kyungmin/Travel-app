// 회원 가입 페이지

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../component/register.dart';
import '../component/validator.dart';
import '../widget/checkbox.dart';
import '../widget/textfield.dart';
import 'login_screen.dart';

enum LoginPlatform { naver, none }

LoginPlatform _loginPlatform = LoginPlatform.none;

class RegisterScreen extends HookConsumerWidget {
  RegisterScreen({super.key});

  bool isSignupScreen = true;
  final _authentication = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();

  // naver 로그인
//   void _login_naver() anync {
//     NaverLoginResult res = await FlutterNaverLogin.logIn();
//     setState(() {
//       n_name = res.account.nickname;
//       n_email = res.account.birthday
//     });
// }

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
  Widget build(BuildContext context, WidgetRef ref) {
    // TextEditingController controller_name = TextEditingController();
    final isChecked = useState(false);
    final isChecked2 = useState(false);
    final isChecked3 = useState(false);
    final userName = useValueNotifier('');
    final userEmail = useValueNotifier('');
    final userPassword = useValueNotifier('');

    final TextEditingController _emailController = useTextEditingController();
    final TextEditingController _pwController = useTextEditingController();
    final TextEditingController _nameController = useTextEditingController();

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
                          userName.value = value;

                          print(userName);
                        },
                        decoration: registerDecoration(hint: '이름(필수)'),
                      )),

                  // 메일 입력폼
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: _emailController,
                        key: ValueKey(2),
                        validator: emailvalidator,
                        onChanged: (value) {
                          userEmail.value = value;
                        },
                        decoration: registerDecoration(
                            hint: 'Email(필수)', icon: Icons.email_outlined),
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
                          userPassword.value = value;
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
                          userPassword.value = value!;
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
                  checkBoxForm(isChecked: isChecked, text: '이용약간 동의 보기'),

                  // 개인정보수집·이용 동의 체크박스
                  Row(children: <Widget>[
                    SizedBox(
                        height: 25,
                        child: Checkbox(
                            value: isChecked2.value,
                            activeColor: Colors.black,
                            onChanged: (value) {
                              isChecked2.value = value!;
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
                          value: isChecked3.value,
                          activeColor: Colors.black,
                          onChanged: (value) {
                            isChecked3.value = value!;
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
                              tryValidation(_formKey);

                              try {
                                final newUser = await _authentication
                                    .createUserWithEmailAndPassword(
                                  email: userEmail.value,
                                  password: userPassword.value,
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

                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 140),
                        child: SizedBox(
                          height: 45,
                          // width: 370,
                          child: InkWell(
                            onTap: () async {
                              if (await isKakaoTalkInstalled()) {
                                try {
                                  await UserApi.instance.loginWithKakaoTalk();
                                  print('카카오톡으로 로그인 성공');
                                  login_kakao();
                                } catch (error) {
                                  print('카카오톡으로 로그인 실패 $error');

                                  // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                                  try {
                                    await UserApi.instance
                                        .loginWithKakaoAccount();
                                    print('카카오계정으로 로그인 성공');
                                    login_kakao();
                                  } catch (error) {
                                    print('카카오계정으로 로그인 실패 $error');
                                  }
                                }
                              } else {
                                try {
                                  await UserApi.instance
                                      .loginWithKakaoAccount();
                                  print('카카오계정으로 로그인 성공');
                                  login_kakao();
                                } catch (error) {
                                  print('카카오계정으로 로그인 실패 $error');
                                }
                              }
                            },
                            child: Image.asset('assets/kakao_login_circle.png'),
                          ),
                        ),
                      ),

                      // Naver login Button
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: SizedBox(
                          height: 45,
                          // width: 370,
                          child: InkWell(
                            onTap: () async {
                              try {
                                final NaverLoginResult res =
                                    await FlutterNaverLogin.logIn();
                                name = res.account.nickname;
                                isLogin = true;
                                print(res);
                              } catch (error) {
                                print(error);
                                _showSnackError(error.toString());
                              }
                            },
                            child: Image.asset('assets/btnG_아이콘원형.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
