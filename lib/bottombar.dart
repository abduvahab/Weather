import 'package:flutter/material.dart';
import './city.dart';
import './utils.dart';

class Currently extends StatelessWidget{

  final String text;
  final CityToDisplay displaycity;
  const Currently({
    super.key, 
    required this.text,
    required this.displaycity,
    });

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        // const Text(
        // "Currently",
        // style: TextStyle(fontSize: 40.0),
        // ),
        Visibility(
          visible: displaycity.name != "",
          child:CityCurrent(displaycity: displaycity,),
        ),

      ]
    );
  }
}
class Today extends StatelessWidget{

  final String text;
  final CityToDisplay displaycity;
  const Today({
    super.key, 
    required this.text,
    required this.displaycity,
    });

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        // const Text(
        // "Today",
        // style: TextStyle(fontSize: 40.0),
        // ),
        Visibility(
          visible: displaycity.name != "",
          child:Expanded(
            child:CityToday(displaycity: displaycity,) 
            ),
        ),

      ]
    );
  }
}
class Weekly extends StatelessWidget{

  final String text;
  final CityToDisplay displaycity;
  const Weekly({
    super.key, 
    required this.text,
    required this.displaycity,
    });

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        // const Text(
        // "Weekly",
        // style: TextStyle(fontSize: 40.0),
        // ),
        Visibility(
          visible: displaycity.name != "",
          child:Expanded(
            child: CityWeek(displaycity: displaycity,),
          ),
        ),

      ]
    );
  }
}