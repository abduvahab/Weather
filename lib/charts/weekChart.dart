import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WeekChart extends StatelessWidget{

  final double minY;
  final double maxY;
  final List<double> min_temp;
  final List<double> max_temp;
  final List<String> time;
  // final List<String> time=[];

  WeekChart(this.min_temp, this.max_temp, this.time)
          :maxY = max_temp.reduce((value, element) => value > element ? value:element),
           minY = min_temp.reduce((value, element) => value > element? element:value);
  //          {
  //               for (var i=0; i< times.length;i++){
  //           List<String>  cut= times[i].split('-');
  //           time.add('${cut[2]}/${cut[1]}');
  //         }

  // }

  @override
  Widget build(BuildContext context){
    return LineChart(
      LineChartData(
        minX:0,
        maxX: (min_temp.length).toDouble(),
        minY: minY > 0 ? 0:minY.toInt() - ((minY.toInt() % 4 )),
        maxY: maxY.toInt() + 4- (maxY.toInt() % 4),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 4,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Container(
                child: Text(
                  '${value.toInt().toString()}\u00B0C',
                  style:const  TextStyle(
                    color: Colors.white
                  ),
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 25,
              interval: 1,
              getTitlesWidget: (value, meta) {
                 final index= value;
                 if(index < time.length){
                  return Container(
                    margin:const EdgeInsets.only(left: 40.0),
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text(
                      time[index.toInt()],
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                 }
                 else{
                  return const SizedBox();
                 }

              },
            ),
          ),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false,)),
          topTitles: AxisTitles(
            axisNameSize: 30,
            axisNameWidget: Container(
              child: const Text(
                "Weekly Temperature",
                 style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white
                ),
              ),
            ),
            sideTitles: const SideTitles(showTitles: false),
          ), 
        ),
        gridData:  FlGridData(
            show: true,
          horizontalInterval: 1,
          verticalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return const FlLine(
                color: Color.fromARGB(255, 197, 168, 82),
                strokeWidth: 1,
                dashArray: [1,1],
              );
            },
            getDrawingVerticalLine: (value) {
              return const FlLine(
                color: Color.fromARGB(255, 197, 168, 82),
                strokeWidth: 1,
                dashArray: [1,1],
              );
            },
        ),
        borderData: FlBorderData(
          // border: Border.all(width: 1,color: Colors.grey),
          border: const Border(
            top: BorderSide(width: 2,color: Colors.grey),
            bottom: BorderSide(width: 2,color: Color.fromARGB(255, 227, 225, 225)),
            right: BorderSide(width: 2,color: Colors.grey),
            left: BorderSide(width: 2,color: Color.fromARGB(255, 227, 225, 225)),
            // left: BorderSide.
          ),
          show: true,
        ),
        lineBarsData: [
          LineChartBarData(
            //  FlSpot(index.toDouble(), min_temp[index])
            spots: List.generate(min_temp.length , (index)=>FlSpot(index.toDouble()+ 0.5, min_temp[index])),
            isCurved: true,
            color:const Color.fromARGB(255, 31, 213, 21),
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index)=>FlDotCirclePainter(
                  radius: 4,
                  color: Color.fromARGB(255, 232, 236, 16), // Change dot color conditionally
                  strokeWidth: 2,
                  strokeColor: Colors.white,
              ),
            ),
          ),
          LineChartBarData(
            spots: List.generate(max_temp.length, (index) => FlSpot(index.toDouble()+0.5, max_temp[index])),
            isCurved: true,
            color:const Color.fromARGB(255, 8, 143, 233),
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index)=>FlDotCirclePainter(
                  radius: 4,
                  color: Color.fromARGB(255, 232, 9, 147), // Change dot color conditionally
                  strokeWidth: 2,
                  strokeColor: Colors.white,
              ),
            ),
          ),
        ],

      ),
    );
  }
}