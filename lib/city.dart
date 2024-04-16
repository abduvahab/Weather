
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import './utils.dart';
import 'charts/todayChart.dart';
import 'charts/weekChart.dart';
import './weather/hours.dart';
import './weather/days.dart';

class CityCurrent extends StatelessWidget{

  final CityToDisplay displaycity;
  const CityCurrent({
    super.key,
    required this.displaycity
    });

  @override
  Widget build(BuildContext context){
    return  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Text(
                displaycity.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Color.fromARGB(255, 32, 239, 177),
                  fontWeight: FontWeight.bold
                  
                  ),
                ),
                Text(
                '${displaycity.admin1} ${displaycity.admin1 !='' ? ',':""} ${displaycity.country}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30.0,
                  color: Color.fromARGB(255, 210, 209, 209),
                  
                  ),
                ),               
                Container(
                  padding: const EdgeInsets.only(top: 35.0),
                  alignment: Alignment.center,
                  child:Text(
                    '${displaycity.current.apparent_temperature.toString()}\u00B0C',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 60.0,
                      color: Color.fromARGB(255, 105, 238, 38),
                      fontWeight: FontWeight.w700
                      ),
                    ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15.0),
                  alignment: Alignment.center,
                  child: Text(
                    displaycity.current.Condition,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(255, 32, 239, 177),
                      
                      ),
                    ),
                ),

                // const SizedBox(
                //   height: 30.0,
                // ),
                Container(
                 padding: const EdgeInsets.only(top: 1.0),
                 alignment: Alignment.center,
                  width: 120.0,
                  height: 120.0,
                  child: Image.asset('lib/asset/weather_icons/${displaycity.current.path}',fit: BoxFit.fill,),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20.0),
                  alignment: Alignment.center,
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 10.0,bottom: 7.0),
                        alignment: Alignment.topCenter,
                        child: const Icon(WeatherIcons.strong_wind,color: Colors.white, size:20.0),
                      ),
                        
                        // Icon(Icons.speed_outlined, color: Colors.white,),
                        Text(
                          '${displaycity.current.wind_speed_10m.toString()}Km/h',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Color.fromARGB(255, 231, 235, 229),
                            ),
                        ),
                    ],
                  ),

                ),
            
            ],
          );
  }
}
class CityToday extends StatelessWidget{

  final CityToDisplay displaycity;
  const CityToday({
    super.key,
    required this.displaycity
    });

  @override
  Widget build(BuildContext context){
    return  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    displaycity.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(255, 32, 239, 177),
                      fontWeight: FontWeight.bold
                      
                      ),
                    ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    '${displaycity.admin1} ${displaycity.admin1 !='' ? ',':""} ${displaycity.country}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30.0,
                      color: Color.fromARGB(255, 210, 209, 209),
                      
                      ),
                    ),
                ),
 
                Expanded(
                  child:Container(
                    margin: const EdgeInsets.all(10.0),
                    padding:const EdgeInsets.only(
                      left: 5.0,
                      right: 10.0,
                      top: 5.0,
                      bottom: 10.0
                      ),
                    color: const Color.fromARGB(255, 68, 88, 99),
                    child:TodaysChart(displaycity.hourly.apparent_temperature),
                )
                  ),
                
                OneLineDay(hourly: displaycity.hourly,),
            
            ],
          );
  }
}


class OneLineDay extends StatelessWidget{
 final HourlyWeather hourly;
 const OneLineDay({
  super.key,
  required this.hourly
 });
 @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      width: double.infinity,
      height: 200,
      child:ListView.builder(
        itemCount: 24,
        scrollDirection: Axis.horizontal,
        // reverse: true,
        itemBuilder: (context, index) {
          return Container(
            // color: Colors.blueAccent[50+index*10],
            margin:const  EdgeInsets.symmetric(horizontal: 15.0),
            
            child: OneLineHour(
              hourly: hourly,
              index: index,
            ),
          );
        },
      ), 
    );
  }

}



class OneLineHour extends StatelessWidget{
  final HourlyWeather hourly;
  final int index;
  const OneLineHour({
    super.key,
    required this.hourly,
    required this.index,
  });

  @override
  Widget build(BuildContext context){
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          hourly.time[index],
          textAlign: TextAlign.center,
          style: const TextStyle(
            // fontSize: 40.0,
            color: Color.fromARGB(255, 246, 242, 242),
            ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 20,top: 5),
          child: Icon(hourly.icons[index], size: 32,color: const Color.fromARGB(255, 32, 239, 177),),
        ),
        Container(
           padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            '${hourly.apparent_temperature[index].toString()}\u00B0C',
            textAlign: TextAlign.center,
            style: const TextStyle(
              // fontSize: 40.0,
              color: Color.fromARGB(255, 235, 242, 27),
              ),
          ),
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 10.0,bottom: 7.0),
              alignment: Alignment.topCenter,
              child: const Icon(WeatherIcons.strong_wind,color: Colors.white, size:20.0),
            ),
            Text(
              '${hourly.wind_speed_10m[index].toString()}Km/h',
              textAlign: TextAlign.center,
              style: const TextStyle(
                // fontSize: 40.0,
                color: Color.fromARGB(255, 244, 242, 242),
                ),
            ),

          ],
        )
      
      ],

    );
  }

}



class CityWeek extends StatelessWidget{
  final CityToDisplay displaycity;

  const CityWeek({
    super.key,
    required this.displaycity,
  });

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Container(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              displaycity.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20.0,
                color: Color.fromARGB(255, 32, 239, 177),
                fontWeight: FontWeight.bold
                
                ),
              ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Text(
              '${displaycity.admin1} ${displaycity.admin1 !='' ? ',':""} ${displaycity.country}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30.0,
                color: Color.fromARGB(255, 210, 209, 209),
                
                ),
              ),
          ),
          
          Expanded(
            child: Container(
                margin: const EdgeInsets.all(5.0),
                color: const Color.fromARGB(255, 64, 90, 94),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        // margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.only(
                          // top: 5.0,
                          right: 10.0,
                          left: 5.0,
                          // bottom: 5.0
                        ),
                        // color: 
                        child:  WeekChart(
                          displaycity.week.apparent_temperature_min,
                          displaycity.week.apparent_temperature_max, 
                          displaycity.week.time
                        ),
                      )
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.legend_toggle,color: Color.fromARGB(255, 31, 213, 21),),
                        Container(
                          margin: EdgeInsets.only(right: 15.0),
                          child: const Text("Min temperature", style: TextStyle(color: Color.fromARGB(255, 227, 225, 225)),),
                        ),
                        const Icon(Icons.legend_toggle,color: Color.fromARGB(255, 8, 143, 233),),
                        Container(
                          
                          child: const Text("Max temperature", style: TextStyle(color: Color.fromARGB(255, 227, 225, 225)),),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0,)
                  ],
                ),
              ),
            ),
         
          DaysOfWeek(week:displaycity.week),
      ],
    );
  }
}

class DaysOfWeek extends StatelessWidget{

  final Week week;
  const DaysOfWeek({
    super.key,
    required this.week,
  });

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(top: 20.0,bottom: 20.0),
      width: double.infinity,
      height: 200,
      child: ListView.builder(
      itemCount: 7,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index){
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          alignment: Alignment.center,
          // color: Colors.amber,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

                Container(
                  // alignment: Alignment.centerLeft,
                  child:Text(
                    week.time[index],
                    // textAlign: TextAlign.center,
                    style: const TextStyle(
                      // fontSize: 40.0,
                      color: Color.fromARGB(255, 235, 231, 231),
                      ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: Icon(week.icons[index],color: const Color.fromARGB(255, 139, 234, 6),size: 40,),
                ),
                
                Container(
                  margin: const EdgeInsets.only(top: 15.0),
                  alignment: Alignment.center,
                  child: Text(
                    '${week.apparent_temperature_max[index].toString()}\u00B0C Max',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      // fontSize: 40.0,
                      color: Color.fromARGB(255, 8, 143, 233),
                      ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  alignment: Alignment.center,
                  child:Text(
                    '${week.apparent_temperature_min[index].toString()}\u00B0C Min',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      // fontSize: 40.0,
                      color: Color.fromARGB(255, 50, 159, 7),
                      ),
                  ),
                ),


                // Text(
                //   week.conditions[index],
                //   textAlign: TextAlign.center,
                //   style: const TextStyle(
                //     // fontSize: 40.0,
                //     color: Color.fromARGB(255, 241, 238, 238),
                //     ),
                // ),
            ],
          ),
        );
      },
    )
    );
  }
}



