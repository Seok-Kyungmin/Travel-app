import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:internship/data/my_location.dart';
import 'package:internship/data/network.dart';
import 'package:internship/screens/weather_screen.dart';

const apiKey = '10dfceb95f490ada0c3b949a03de55da';

class LoadingPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    double? latitude3;
    double? longitude3;

    // void fetchData() async{
    //   http.Response response = await http.get(Uri.parse('https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1'));
    //   if(response.statusCode == 200){
    //     String jsonData = response.body;
    //     var parsingData = jsonDecode(jsonData);
    //     var myJson = parsingData['weather'][0]['description'];
    //     print(myJson);
    //
    //     var wind = parsingData['wind']['speed'];
    //     print(wind);
    //
    //     var id = parsingData['id'];
    //     print(id);
    //   } else{
    //     print(response.statusCode);
    //   }
    // }

    void getLocation() async {
      MyLocation myLocation = MyLocation();
      await myLocation.getMyCurrentLocation();
      latitude3 = myLocation.latitude2;
      longitude3 = myLocation.longitude2;
      print(latitude3);
      print(longitude3);

      Network network = Network(
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric');

      var weatherData = await network.getJsonData();
      print(weatherData);
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return WeatherScreen(parseWeatherData: weatherData,);
      }));
    }

    useEffect(() {
      getLocation();
    });

    return Container(
        child: Stack(
          children: [
            Image.asset(
              'assets/background.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: SpinKitRotatingCircle(
                color: Colors.white,
              ),)
          ],
        )
    );
  }
}
