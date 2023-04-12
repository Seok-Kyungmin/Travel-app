import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';
import 'main_screen.dart';

// 로그인 페이지
class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

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
  Widget build(BuildContext context) {
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
                    validator: (String? value) {
                      if (value == _pwController.text) {
                        return null;
                      } else {
                        return '이메일을 다시 입력하세요.';
                      }
                    },
                    onSaved: (value) {
                      userEmail = value!;
                    },
                    onChanged: (value) {
                      userEmail = value;
                    },
                    decoration: const InputDecoration(
                      hintText: '이메일 또는 전화번호',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),

                // 비밀번호 입력폼
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    key: ValueKey(2),
                    obscureText: true,
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
                    onChanged: (value) {
                      userPassword = value;
                    },
                    decoration: const InputDecoration(
                      labelText: '비밀번호',
                      labelStyle: TextStyle(
                        color: Colors.grey, //<-- SEE HERE
                      ),
                    ),
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),

                // 로그인 버튼
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: GestureDetector(
                    child: SizedBox(
                      height: 45,
                      width: 370,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (isSigninScreen) {
                            _tryValidation();
                            try {
                              final newUser =
                                await _authentication.signInWithEmailAndPassword(
                                  email: userEmail,
                                  password: userPassword,
                                );

                              if (newUser.user != null) {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => MainPage()),
                                );
                              }
                            }catch(e){
                              print(e);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                  Text('이메일과 비밀번호를 확인해주세요'),
                                  backgroundColor: Colors.blue,
                                ),
                              );
                            }
                          }
                        },
                        child: Text('Gnet 계정 로그인'),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Color(0xFFF5F5F5),
                          foregroundColor: Colors.black87,
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // 회원가입 버튼
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 45,
                    width: 370,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SecondPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Color(0xFFF5F5F5), // Background color
                        onPrimary: Colors.black87,
                      ), // Text Color (Foreground color)
                      child: const Text(
                        '새로운 Gnet 계정 만들기',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
              ]))),
    );
  }
}
