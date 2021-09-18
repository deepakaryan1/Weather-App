import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  int humidity;
  int windSpeed;
  String weatherIcon;
  String cityName;
  String weatherMessage;
  String cName;
  int minTemp;
  int maxTemp;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'NA';
        weatherMessage = 'NA';
        cityName = 'NA';
        minTemp = 0;
        maxTemp = 0;
        windSpeed = 0;
        return;
      }
      double temp = weatherData['main']['temp'];
      humidity = weatherData['main']['humidity'];
      double speed = weatherData['wind']['speed'];
      double min_temp = weatherData['main']['temp_min'];
      double max_temp = weatherData['main']['temp_max'];
      minTemp = min_temp.toInt();
      maxTemp = max_temp.toInt();
      windSpeed = speed.toInt();
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            // height: 1.0*(MediaQuery.of(context).size.width),
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.blue.withOpacity(0.5), BlendMode.dstIn),
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1530908295418-a12e326966ba?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzB8fHdlYXRoZXJ8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80"),
              ),
            ),

            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  padding: EdgeInsets.all(2),
                  margin: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      // GestureDetector(
                      //   onTap: ()async {
                      //     var weatherData =
                      //         await weather.getCityWeather(cityName);
                      //         updateUI(weatherData);
                      //   },
                      //   child: Icon(
                      //     Icons.search,
                      //     size: 35,
                      //     color: Colors.blue,
                      //   ),
                      // ),
                      FlatButton(
                        onPressed: () async {
                          
                          var weatherData = await weather.getCityWeather(cName);
                          updateUI(weatherData);
                        },
                        child: Icon(
                          Icons.search,
                          size: 35.0,
                          color: Colors.blue,
                        ),
                      ),

                      Expanded(
                          child: TextField(
                        onChanged: (value) {
                          cName = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Search any city name",
                          hintStyle: TextStyle(fontSize: 25),
                          border: InputBorder.none,
                        ),
                      )),
                    ],
                  ),
                ),
                Card(
                  color: Colors.transparent,
                  elevation: 10.0,
                  child: Container(
                    width: 0.9 * (MediaQuery.of(context).size.width),
                    height: 0.40 * (MediaQuery.of(context).size.width),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                    ),
                    // borderRadius: BorderRadius.circular(25)),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weatherIcon,
                          style: kConditionTextStyle,
                        ),
                        SizedBox(
                          width: 0.08 * (MediaQuery.of(context).size.width),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height:
                                  0.08 * (MediaQuery.of(context).size.width),
                            ),
                            Text(
                              '$weatherMessage In ',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '$cityName',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Colors.transparent,
                  margin: EdgeInsets.symmetric(vertical: 15),
                  elevation: 10.0,
                  child: Container(
                    width: 0.9 * (MediaQuery.of(context).size.width),
                    height: 0.6 * (MediaQuery.of(context).size.width),
                    padding: EdgeInsets.all(30),
                    // margin: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      // borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.fireplace),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$temperature°',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 85,
                              ),
                            ),
                            Text(
                              'C',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '$minTemp°C',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              '$maxTemp°C',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      color: Colors.transparent,
                      // margin: EdgeInsets.symmetric(vertical: 5),
                      elevation: 10.0,
                      child: Container(
                        width: 0.4 * (MediaQuery.of(context).size.width),
                        height: 0.5 * (MediaQuery.of(context).size.width),
                        padding: EdgeInsets.all(20),
                        // margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          // borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.air_sharp),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              '$windSpeed',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              "km/h",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.transparent,
                      // margin: EdgeInsets.symmetric(vertical: 5),
                      elevation: 10.0,
                      child: Container(
                        width: 0.4 * (MediaQuery.of(context).size.width),
                        height: 0.5 * (MediaQuery.of(context).size.width),
                        padding: EdgeInsets.all(20),
                        // margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          // borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text("Text"),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.1 * (MediaQuery.of(context).size.width),
                )
              ],
            ),
          ),
        ),
      ),
    );
    // return Scaffold(
    //   body: SafeArea(
    //     child: Container(
    //       decoration: BoxDecoration(
    //         image: DecorationImage(
    //           image: AssetImage('images/location_background.jpg'),
    //           fit: BoxFit.cover,
    //           colorFilter: ColorFilter.mode(
    //               Colors.white.withOpacity(0.8), BlendMode.dstATop),
    //         ),
    //       ),
    //       constraints: BoxConstraints.expand(),
    //       child: SafeArea(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           crossAxisAlignment: CrossAxisAlignment.stretch,
    //           children: <Widget>[
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: <Widget>[
    //                 FlatButton(
    //                   onPressed: () async {
    //                     var weatherData = await weather.getLocationWeather();
    //                     updateUI(weatherData);
    //                   },
    //                   child: Icon(
    //                     Icons.near_me,
    //                     size: 50.0,
    //                   ),
    //                 ),
    //                 Icon(Icons.search),
    //                 Expanded(child: TextField(
    //                   decoration: InputDecoration(
    //                     border: InputBorder.none,
    //                     hintText: " Search any city Name"
    //                   ),
    //                 )),
    //                 FlatButton(
    //                   onPressed: () async {
    //                     var typedName = await Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                         builder: (context) {
    //                           return CityScreen();
    //                         },
    //                       ),
    //                     );
    //                     if (typedName != null) {
    //                       var weatherData =
    //                           await weather.getCityWeather(typedName);
    //                       updateUI(weatherData);
    //                     }
    //                   },
    //                   child: Icon(
    //                     Icons.location_city,
    //                     size: 50.0,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             Padding(
    //               padding: EdgeInsets.only(left: 15.0),
    //               child: Row(
    //                 children: <Widget>[
    //                   Text(
    //                     '$temperature°',
    //                     style: kTempTextStyle,
    //                   ),
    //                   Text(
    //                     weatherIcon,
    //                     style: kConditionTextStyle,
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Padding(
    //               padding: EdgeInsets.only(right: 15.0),
    //               child: Text(
    //                 '$weatherMessage in $cityName',
    //                 textAlign: TextAlign.right,
    //                 style: kMessageTextStyle,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
