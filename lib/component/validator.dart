String emailvalidator(value) {
  if (value == "") {
    return "이메일을 입력하세요";
  } else if (!RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(value!)) {
    return '잘못된 이메일 형식입니다.';
  } else {
    return '';
  }
}
