import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();


  }

  void getLocationData() async {

    var weatherData = await WeatherModel().getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // backgroundColor: Colors.blue[300],
      body: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LocationScreen(
              locationWeather: null,
            );
          }));
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/clipart.png"),
            ),
          ),
          child: Center(

            child: Column(

              children: [
                SizedBox(height: 100),
                Container(child: Image.asset("images/clima.png"),
                  width: 0.3*(MediaQuery.of(context).size.width),
                ),
                SizedBox(height: 40),
                Text("Clima", style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,

                ),),
                SizedBox(height: 10),
                Text("The Live Weather"),
                SizedBox(height: 100),
                SpinKitDoubleBounce(
                  color: Colors.white,
                  size: 100.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
