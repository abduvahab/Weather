
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocode/geocode.dart';
import 'dart:async';
import './weather/current.dart';
import './weather/hours.dart';
import './weather/days.dart';
import './topbar.dart';
import './bottombar.dart';
import './utils.dart';
import './error.dart';
import './bodys.dart';





class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  int index = 0;
  String serach = "";
  String error = "";
  String latittude = "";
  String longitude = "";
  bool    access = true;
  bool    searcherror = false;
  String    searcherrortext = "";
  List<City> citylist=[];
  late Address mylocation;
  CityToDisplay displaycity= CityToDisplay(
              name:"",
              latitude:-1,
              longitude:-1,
              country:"",
              admin1:"",
              timezone:""
  );
  _MyHomeState(){
    determinePosition();
  }
  TextEditingController controller = TextEditingController();

  FocusNode focusNode = FocusNode();
  @override
  void dispose(){
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    // focusNode = FocusNode();
    // focusNode.addListener(() {
    //   // print('Listener');
    // });
  }

  void handlSerachFieldSubmit(String text)async{
    if(controller.text.isEmpty){
      setState(() {
        citylist.clear();
      });
      return ;
    }
    try{
      if (citylist.isEmpty){
        throw Exception("Couldn't find any result for the supplied city name");
      }
      CurrentWeather current  = await getCurrentWeather(
          citylist[0].latitude.toString(),
          citylist[0].longitude.toString()
      );   
      HourlyWeather hourly  = await getHourlyWeather(
          citylist[0].latitude.toString(),
          citylist[0].longitude.toString()
      );
      Week week= await getWeeklyWeather(
            citylist[0].latitude.toString(),
            citylist[0].longitude.toString()
      ); 
      setState(() {
          if(text != ""){
            serach = text;
            controller.clear();
            access = true;
            displaycity = CityToDisplay(
                name:citylist[0].name,
                latitude:citylist[0].latitude,
                longitude:citylist[0].longitude,
                country:citylist[0].country,
                admin1:citylist[0].admin1,
                timezone:citylist[0].timezone
            );
            displaycity.current = current;
            // displaycity.current = current;
            displaycity.hourly = hourly;
            displaycity.week = week;
            citylist.clear();
          }
        });

    }catch(e){
      setState(() {
          access = false;
          citylist.clear();
          error = e.toString();
      });
      debugPrint(e.toString());
    }
  
 
  }

  void taponCityList(City city)async {
    try{
      CurrentWeather current  = await getCurrentWeather(
        city.latitude.toString(),
        city.longitude.toString()
      );
      HourlyWeather hourly  = await getHourlyWeather(
        city.latitude.toString(),
        city.longitude.toString()
      ); 
      Week week = await getWeeklyWeather(
        city.latitude.toString(),
        city.longitude.toString()
      );
      setState(() {
        displaycity = CityToDisplay(
          name:city.name,
          latitude:city.latitude,
          longitude:city.longitude,
          country:city.country,
          admin1:city.admin1,
          timezone:city.timezone
        );
        displaycity.current = current;
        displaycity.hourly = hourly;
        displaycity.week = week;
        citylist.clear();
        controller.clear();
        access = true;
      });
    }catch(e){
      setState(() {
          access = false;
          citylist.clear();
          // error = "Geolocation isn't available,please enable it in your device";
          error = e.toString();
      });
      debugPrint(e.toString());
    }

  }
  void handlSerachButtonPress()async{
    if(controller.text.isEmpty){
      setState(() {
        citylist.clear();
      });
      return ;
    }
    try{
      if (citylist.isEmpty){
        throw Exception("Couldn't find any result for the supplied city name");
      }
      CurrentWeather current  = await getCurrentWeather(
        citylist[0].latitude.toString(),
        citylist[0].longitude.toString()
      );
      HourlyWeather hourly  = await getHourlyWeather(
        citylist[0].latitude.toString(),
        citylist[0].longitude.toString()
      );
      Week week = await getWeeklyWeather(
        citylist[0].latitude.toString(),
        citylist[0].longitude.toString()
      );
      setState(() {
        if(controller.text != ""){
          serach = controller.text;
          controller.clear();
          access = true;
          // debugPrint(serach);
          displaycity = CityToDisplay(
              name:citylist[0].name,
              latitude:citylist[0].latitude,
              longitude:citylist[0].longitude,
              country:citylist[0].country,
              admin1:citylist[0].admin1,
              timezone:citylist[0].timezone
          );
          displaycity.current = current;
          displaycity.hourly = hourly;
          displaycity.week = week;
          citylist.clear();
        }
        // debugPrint(serach);
      });
    }catch(e){
      setState(() {
          access = false;
          citylist.clear();
          // error = "Geolocation isn't available,please enable it in your device";
          error = e.toString();
      });
      debugPrint(e.toString());
    }
    
  }
  void handlSerachFieldChange(String text)async{
    if(text.isEmpty){
      setState(() {
        citylist.clear();
      });
      return ;
    }
    try{
      // debugPrint(text);
      List<City> list = await getCityListByName(text);
      setState(() {
        if(list.isEmpty){
          citylist.clear();
          searcherror = true;
          searcherrortext = "no result for the city name";
        }else{
          access = true;
          searcherror = false;
          citylist = list;
        }
      });
      return ;
    }catch(e){
      setState(() {
        citylist.clear();
        // searcherror = true;
        access = false;
        searcherrortext = "The service connect is lost, please check your internet connection or try again later";
      });      
      debugPrint(e.toString());
    }
  }

  Future<void> determinePosition() async {
    try{
      Position position = await getCurrentPosition();
      Address addr = await getCityInfo(position);
      CurrentWeather current  = await getCurrentWeather(
        position.latitude.toString(),
        position.longitude.toString()
      );
      HourlyWeather hourly  = await getHourlyWeather(
        position.latitude.toString(),
        position.longitude.toString()
      );
      Week week = await getWeeklyWeather(
        position.latitude.toString(),
        position.longitude.toString()
      );
      setState(() {
        mylocation = addr;
        displaycity = CityToDisplay(
              name:addr.city?? "",
              latitude:position.latitude,
              longitude:position.longitude,
              country:addr.countryName?? "",
              admin1:addr.region?.split(',')[1] ?? "",
              timezone:addr.timezone?? ""
        );
        displaycity.current = current;
        displaycity.hourly = hourly;
        displaycity.week = week;
        // latittude = position.latitude.toString();
        // longitude = position.longitude.toString();
        access = true;
        // serach = '$latittude $longitude';
        // serach = '$latittude $longitude ${mylocation.city} ${mylocation.postal} ${mylocation.countryName}';
      });
    }catch(e){
      setState(() {
          access = false;
          citylist.clear();
          // error = "Geolocation isn't available,please enable it in your device";
          error = e.toString();
      });
      debugPrint(e.toString());
    }
  }



  @override
  Widget build(BuildContext context) {
    List<Widget> pages=[
      Currently(text: serach,displaycity: displaycity,),
      Today(text: serach,displaycity: displaycity,),
      Weekly(text: serach,displaycity: displaycity,)
    ];
     
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 66, 65, 83),
        title: TopBar(
          controller: controller,
          handlSubmit: handlSerachFieldSubmit,
          focusNode:focusNode,
          onChange: handlSerachFieldChange,
          onPressedSearch: handlSerachButtonPress,
          onPressedLocation: (){
              determinePosition();
          },
        ),
      ),
      resizeToAvoidBottomInset: true,
      body:Stack(
        fit: StackFit.expand,
        children: [
          // Image(image: const AssetImage('lib/asset/back_ground.jpg'),
          // Image(image: const AssetImage('lib/asset/mountain.jpg'),
          // Image(image: const AssetImage('lib/asset/dark.jpg'),
          Image(image: const AssetImage('lib/asset/back2.jpg'),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
          ),
          
          access ?  Bodys(
            bodytop: pages[index],
            citylist: citylist,
            onTap: taponCityList,
          ): ErrorMessage(message: error,),
        ],
      ),

      bottomNavigationBar:  BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 66, 65, 83),
        selectedItemColor: Color.fromARGB(255, 37, 196, 240),
        unselectedItemColor: const Color.fromARGB(255, 224, 228, 231),
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items:const [
          BottomNavigationBarItem(
            label:"Currently",
            // backgroundColor: Color.fromARGB(255, 237, 239, 241),
            icon:Icon(Icons.settings,size: 32)
          ),
          BottomNavigationBarItem(
            label: "Today",
            icon:Icon(Icons.today,size: 32)
          ),
          BottomNavigationBarItem(
            label: "Weekly",
            icon:Icon(Icons.calendar_month,size: 32)
          ),
        ],
        ),
    );
  }
}


