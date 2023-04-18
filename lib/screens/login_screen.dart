import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internship/screens/register_screen.dart';

import '../component/validator.dart';
import '../component/register.dart';
import '../widget/textfield.dart';
import 'main_screen.dart';
import '../widget/loginbutton.dart';
import '../widget/dialog.dart';

// 로그인 페이지
class LoginPageState extends HookConsumerWidget {
  LoginPageState({super.key});

  final _authentication = FirebaseAuth.instance;
  bool isSigninScreen = true;
  User? loggedUser;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String userName = '';
  String userEmail = '';
  String userPassword = '';

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Form(
          key: _formKey,
          child: Center(
              child: Column(children: [
            const Padding(
              padding: EdgeInsets.only(top: 80),
              child: Text(
                'Gnet 계정을 시작합니다',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(20),
              child: Text('사용하던 Gnet계정이 있다면\n이메일 또는 전화번호로 로그인해 주세요.',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
            ),

                // 이메일 또는 전화번호 입력폼
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: TextFormField(
                    key: ValueKey(1),
                    validator: emailvalidator,
                    onSaved: (value) {
                      userEmail = value!;
                    },
                    onChanged: (value) {
                      tryValidation2(_formKey);
                    },
                    decoration: loginDecoration(label: '이메일 또는 전화번호'),
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),

                // 비밀번호 입력폼
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    key: ValueKey(2),
                    obscureText: true,
                    validator: pwvalidator,
                    onSaved: (value) {
                      userPassword = value!;
                    },
                    onChanged: (value) {
                      tryValidation2(_formKey);
                    },
                    decoration: loginDecoration(label: '비밀번호'),
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),

            // 로그인 버튼
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: loginButton(
                  onPressed: () async {
                    if (isSigninScreen) {
                      tryValidation2(_formKey);
                      try {
                        final newUser =
                            await _authentication.signInWithEmailAndPassword(
                          email: userEmail,
                          password: userPassword,
                        );

                        if (newUser.user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPageState()),
                          );
                        }
                      } catch (e) {
                        print(e);
                        dialog(context: context,text:'이메일과 비밀번호를 확인해주세요');
                      }
                    }
                  },
                  text: 'Gnet 계정 로그인'),
            ),

            // 회원가입 버튼
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: loginButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                text: '새로운 Gnet 계정 만들기', // Text Color (Foreground color)
              ),
            ),

            // 계정 또는 비밀번호 찾기 버튼
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: TextButton(
                onPressed: () {},
                child: Text('Gnet 계정 또는 비밀번호 찾기'),
                style: TextButton.styleFrom(
                    primary: Colors.black87,
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ),
          ])
          )
      ),
    );
  }
}
