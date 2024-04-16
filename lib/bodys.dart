import 'package:flutter/material.dart';
import './utils.dart';

class Bodys extends StatelessWidget{

  final Widget bodytop;
  final List<City> citylist;
  final void Function(City city) onTap;
  const  Bodys({
    Key? key,
    required this.bodytop,
    required this.citylist,
    required this.onTap,
  }):super(key: key);
  @override
  Widget build(BuildContext context){
    return Center(
      child:Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Visibility(
          visible: citylist.isEmpty,
          child: Expanded(
            child: bodytop,
          ),
        ),
        Visibility(
          visible: citylist.isNotEmpty,
            child:  Expanded(
              child: ListView.builder(
                itemCount: citylist.length >=5 ? 5 : citylist.length,
                // itemCount: citylist.length,
                itemBuilder: (context, index) {
                  return OneCity(
                    city: citylist[index],
                    onTap: onTap,
                  );
                },
            
              )
            ),
        ),

      ],
    )
    );
  }
}

class OneCity extends StatelessWidget{
  final City city;
  final void Function(City city) onTap;
  const OneCity({
    super.key,
    required this.city,
    required this.onTap
  });

  @override
  Widget build(BuildContext context){
    return Container(
            margin:const EdgeInsets.only(left: 25.0,right: 10.0),
            // padding: EdgeInsets.only(top: 5.0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0,color:  Color.fromARGB(255, 198, 196, 196))
                // top: BorderSide(width: 1.0,color:  Color.fromARGB(255, 198, 196, 196))
              )
            ),
            child: ListTile(
              leading: const Icon(Icons.location_city,color: Color.fromARGB(255, 209, 206, 206),),
              title: RichText(
                text:TextSpan(
                  children: [
                        TextSpan(
                          text:city.name,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 240, 236, 236),
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                            ),
                        ),
                        TextSpan(
                          text:' ${city.admin1}, ${city.country}',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 240, 236, 236),
                            fontSize: 15
                          ),
                        )
                  ]
                ),
              ),
              onTap:(){
                // debugPrint('${city.postcodes}');
                  onTap(city);
              },
            ),
          );
  }
}
