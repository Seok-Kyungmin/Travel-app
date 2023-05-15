//위치 정보 받아오기 위해 geolocator 패키지 import
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class MyLocation {
  double? latitude2;
  double? longitude2;

  // await가 사용되었기 때문에 이 메소드는 async 방식이 되어야 함
  Future<void> getMyCurrentLocation() async {
    // loading.dart에서 해당 메소드를 호출할 때 await를 사용했기 때문에 future타입으로 값을 리턴해 주어야 한다.
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude2 = position.latitude;
      longitude2 = position.longitude;
      print(latitude2);
      print(longitude2);
    } catch (e) {
      print("인터넷 연결에 문제가 있습니다.");
    }
  }
}

class KakaoLocation {

  double? latitude22;
  double? longitude22;

  Future<void> getMyCurrentLocation() async {
    final coordinates = await Geolocator.getCurrentPosition();
    final latitude22 = coordinates.latitude;
    final longitude22 = coordinates.longitude;
    print("latitude22");
    print(latitude22);
    print('longitude22');
    print(longitude22);

    final url = Uri.parse(
      'https://dapi.kakao.com/v2/local/geo/coord2address.json?x=$longitude22&y=$latitude22&input_coord=WGS84',
    );
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'cedff17d1b6504b8fb92c7b6a637c896',
      },
    );

    final data = json.decode(utf8.decode(response.bodyBytes))['documents'][0];
    final cityName = data['address']['region_2depth_name'];
  }
}
