import 'package:flutter/material.dart';

///회원가입 필드 데코레이션</br>
///String hint : 필드의 힌트 </br>
///IconData icon : 필드 좌측 아이콘 </br>

InputDecoration registerDecoration(
    {required String hint, IconData icon = Icons.perm_identity}) {
  return InputDecoration(
      border: OutlineInputBorder(),
      prefixIcon: Icon(icon, color: Colors.grey),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 2.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 2.0),
      ),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      contentPadding: const EdgeInsets.all(10));
}

InputDecoration loginDecoration(
    {required String label, IconData icon = Icons.perm_identity}) {
  return InputDecoration(
    labelText: label,
    labelStyle: TextStyle(color: Colors.grey),
  );
}
