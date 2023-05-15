import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Model{
  // 날씨 상태를 수치화하여 해당 수치에 해당하는 svg파일을 불러와야 하므로 widget형 함수 사용
  Widget? getWeatherIcon(int condition){
    if(condition < 300){
      return SvgPicture.asset(
        'assets/svg/climacon-cloud_lightning.svg',
        colorFilter: ColorFilter.mode(Colors.black87, BlendMode.srcIn),
      );
    } else if(condition < 600){
      return SvgPicture.asset(
        'assets/svg/climacon-cloud_snow.svg',
        colorFilter: ColorFilter.mode(Colors.black87, BlendMode.srcIn),
      );
    } else if(condition < 800){
      return SvgPicture.asset(
        'assets/svg/climacon-sun.svg',
        colorFilter: ColorFilter.mode(Colors.black87, BlendMode.srcIn),
      );
    } else if(condition < 804){
      return SvgPicture.asset(
        'assets/svg/climacon-cloud_sun.svg',
        colorFilter: ColorFilter.mode(Colors.black87, BlendMode.srcIn),
      );
    }
  }
}