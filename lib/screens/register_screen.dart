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
import '../widget/dialog.dart';
import 'login_screen.dart';

enum LoginPlatform { naver, none }

LoginPlatform _loginPlatform = LoginPlatform.none;

class RegisterScreen extends HookConsumerWidget {
  RegisterScreen({super.key});

  bool isSignupScreen = true;
  final _authentication = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLogin = false;
  String? accesToken;
  String? expiresAt;
  String? tokenType;
  String? name;
  String? refreshToken;

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
                        validator: namevalidator,
                        onSaved: (value) {
                          userName.value = value!;
                        },
                        onChanged: (String value) {
                          tryValidation(_formKey);
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
                          tryValidation(_formKey);
                        },
                        onSaved: (value) {
                          userEmail.value = value!;
                        },
                        decoration: registerDecoration(
                            icon: Icons.email_outlined, hint: 'Email(필수)'),
                      )),

                  // 비밀번호 입력폼
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: _pwController,
                        key: ValueKey(3),
                        validator: pwvalidator,
                        onChanged: (value) {
                          tryValidation(_formKey);
                        },
                        obscureText: true,
                        decoration: registerDecoration(
                            icon: Icons.lock_outline, hint: '비밀번호 12자리 이하 입력'),
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
                            return '두 비밀번호가 일치하지 않습니다';
                          }
                        },
                        onChanged: (value) {
                          tryValidation(_formKey);
                        },
                        onSaved: (value) {
                          userPassword.value = value!;
                        },
                        obscureText: true,
                        decoration: registerDecoration(
                            icon: Icons.lock_outline, hint: '비밀번호'),
                      )),

                  // 이용약간 동의 체크박스
                  checkBoxForm(isChecked: isChecked, text: '이용약간 동의 보기'),

                  // 개인정보수집·이용 동의 체크박스
                  checkBoxForm(isChecked: isChecked2, text: '개인정보수집·이용 동의 보기'),

                  // 만 14세 이상 체크박스
                  checkBoxForm(isChecked: isChecked3, text: '만 14세 이상입니다.'),

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
                                        builder: (context) => LoginPageState()),
                                  );
                                }
                              } catch (e) {
                                print(e);
                                dialog(
                                    context: context,
                                    text: '이메일과 비밀번호를 확인해주세요');
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

                  // 카카오 & 네이버 로그인
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 140),
                        child: SizedBox(
                          height: 45,
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
                                dialog(
                                    context: context, text: error.toString());
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
