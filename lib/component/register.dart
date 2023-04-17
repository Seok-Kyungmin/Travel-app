import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart'
    show KakaoSdk, User, UserApi, isKakaoTalkInstalled;

void tryValidation(GlobalKey<FormState> formKey) {
  final isValid = formKey.currentState!.validate();
  if (isValid) {
    formKey.currentState!.save();
  }
}

void login_kakao() async {
  try {
    User user = await UserApi.instance.me();
    print('사용자 정보 요청 성공'
        '\n회원번호: ${user.id}'
        '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
  } catch (error) {
    print('사용자 정보 요청 실패 $error');
  }
}
