import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internship/model/model.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'kakaomap_screen.dart';

const String kakaoMapKey = '53310886605c1b898e50f6748e47d107';

class WeatherScreen extends HookConsumerWidget {
  WeatherScreen({this.parseWeatherData});

  final dynamic parseWeatherData;

  Model model = Model();
  String? cityName;
  int? temp;
  late Widget icon;
  String? des;
  double? dust1;
  double? dust2;
  var date = DateTime.now();

  void updateData(dynamic weatherData) {
    double temp2 = weatherData['main']['temp'];
    temp = temp2.round(); // round(): 소수점 아래 반올림해서 int형으로 기온 출력
    int condition = weatherData['weather'][0]['id'];
    des = weatherData['weather'][0]['description'];
    cityName = weatherData['name'];
    icon = model.getWeatherIcon(condition)!;

    print(temp);
    print(cityName);
  }

  //시간 불러오기 메소드
  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;

    useEffect(
      () {
        updateData(parseWeatherData);
      },
    );

    return Scaffold(// body를 appBar까지 확장시킨다는 의미
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'assets/background.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 도시명 & 시간 및 날짜
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Seoul',
                              style: GoogleFonts.lato(
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),

                            // 시간 띄우기
                            Row(
                              children: [
                                TimerBuilder.periodic(
                                  (Duration(minutes: 1)), //1분 단위로 보여주기
                                  builder: (context) {
                                    print('${getSystemTime()}');
                                    return Text(
                                      '${getSystemTime()}',
                                      style: GoogleFonts.lato(
                                          fontSize: 16.0, color: Colors.white),
                                    );
                                  },
                                ),
                                Text(DateFormat(' - EEEE, ').format(date),
                                    style: GoogleFonts.lato(
                                        fontSize: 16.0, color: Colors.white)),
                                Text(
                                    DateFormat('d MMM, yyy').format(date), //일월년
                                    style: GoogleFonts.lato(
                                        fontSize: 16.0, color: Colors.white)),
                              ],
                            ),
                          ],
                        ),

                        // 온도 & 날씨
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$temp\u2103',
                              style: GoogleFonts.lato(
                                fontSize: 60.0,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            Row(children: [
                              icon,
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '$des',
                                style: GoogleFonts.lato(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              )
                            ])
                          ],
                        ),

                        // 지도
                        Column(
                          children: [
                            Divider(
                              height: 15,
                              thickness: 2,
                              color: Colors.white,
                            ),

                            // KakaoMapView
                            KakaoMapView(
                              width: size.width,
                              height: 200,
                              kakaoMapKey: kakaoMapKey,
                              lat: 37.4772,
                              lng: 126.8810,
                              showMapTypeControl: true,
                              showZoomControl: true,
                            ),
                          ],
                        ),

                        // 남겨둠
                        Column(
                            children:[
                              Container(
                                height: 180,
                              )
                            ]
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
