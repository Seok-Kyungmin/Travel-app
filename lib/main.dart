import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(children: [
        const Padding(
          padding: EdgeInsets.only(top: 80),
          child: Text(
            'Gnet 계정을 시작합니다',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text('사용하던 Gnet계정이 있다면\n이메일 또는 전화번호로 로그인해 주세요.',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: TextField(
            decoration: InputDecoration(
              labelText: '이메일 또는 전화번호',
              labelStyle: TextStyle(
                color: Colors.grey, //<-- SEE HERE
              ),
            ),
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            decoration: InputDecoration(
              labelText: '비밀번호',
              labelStyle: TextStyle(
                color: Colors.grey, //<-- SEE HERE
              ),
            ),
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: SizedBox(
            height: 45,
            width: 370,
            child: ElevatedButton(
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage()),);
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
      ])),
    );
  }
}

class SecondPage extends StatefulWidget {
  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  bool _isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: TextFormField(
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
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: TextFormField(
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
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: TextFormField(
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
                          hintText: '비밀번호 6자리 이상입력',
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.all(10)),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: TextFormField(
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
                      // SizedBox(
                      //   width: 40,
                      //   child: TextButton(
                      //     onPressed: () {},
                      //     child: Text('보기'),
                      //     style: TextButton.styleFrom(
                      //         primary: Colors.black87,
                      //         textStyle: TextStyle(
                      //             fontWeight: FontWeight.bold, fontSize: 13)),
                      //   ),
                      // )
                    ])),
                Row(children: <Widget>[
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
                  Text('개인정보수집·이용 동의 보기',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  // SizedBox(
                  //     width: 40,
                  // height: 33,
                  // child:TextButton(
                  //   onPressed: () {},
                  //   child: Text('보기'),
                  //   style: TextButton.styleFrom(
                  //       primary: Colors.black87,
                  //       textStyle: TextStyle(
                  //           fontWeight: FontWeight.bold, fontSize: 12)),
                  // )),
                ]),
                Row(children: <Widget>[
                  SizedBox(
                    height: 25,
                    child: Checkbox(
                        value: _isChecked,
                        activeColor: Colors.black,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        }),
                  ),
                  Text('만 14세 이상입니다.',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ]),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: SizedBox(
                    height: 45,
                    width: 370,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage()),);
                      },
                      child: Text('회원가입'),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
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
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: SizedBox(
                    height: 45,
                    width: 370,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage()),);
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
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: SizedBox(
                    height: 45,
                    width: 370,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage()),);
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
        ));
  }
}
