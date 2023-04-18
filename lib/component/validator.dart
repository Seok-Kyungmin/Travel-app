String? emailvalidator(value) {
  if (value == "") {
    return "이메일을 입력하세요";
  } else if (!RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(value!)) {
    return '잘못된 이메일 형식입니다.';
  } return null;
}

String? namevalidator(value){
  if (value == "") {
    return "이름을 입력하세요";
  }
  if (value.length < 2) {
    return '2자 이상 입력해주세요';
  } return null;
}

String? pwvalidator(value){
  if (value == "") {
    return "비밀번호를 입력하세요.";
  }
  if (value.length < 6 || value.length > 12) {
    return '6자리 ~ 12자리 이내로 입력해주세요.';
  }
  return null;
}



