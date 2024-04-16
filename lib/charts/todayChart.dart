import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TodaysChart extends StatelessWidget{

  final List<double> temperature;
  final double minY;
  final double maxY;

  // List<String> time;
// required this.temperature

  TodaysChart(this.temperature)
    :minY = temperature.reduce((currentMin, element) => element < currentMin ? element : currentMin),
     maxY = temperature.reduce((currentMax, element) => element > currentMax ? element : currentMax);
      
  @override
  Widget build(BuildContext context)=>LineChart(
    LineChartData(
      minY: minY > 0 ? 0: minY.toInt() - ((minY.toInt() % 4 )),
      maxY: maxY.toInt() + 4- (maxY.toInt() % 4),
      titlesData:  FlTitlesData(
        leftTitles: AxisTitles(
        
          sideTitles: SideTitles(
            showTitles: true,
            interval: 4,
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              return Container(
                // margin: EdgeInsets.only(left: 5.0),
                child: Text(
                  '${value.ceil().toString()}\u00B0C',
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
            interval: 3,
            getTitlesWidget: (value, meta) {
              switch (value.toInt()) {
                case 0:
                  return const Text("00:00", style: TextStyle(color: Colors.white),);
                case 3:
                  return const Text("03:00", style: TextStyle(color: Colors.white),);
                case 6:
                  return const Text("06:00", style: TextStyle(color: Colors.white),);
                case 9:
                  return const Text("09:00", style: TextStyle(color: Colors.white),);
                case 12:
                  return const Text("12:00", style: TextStyle(color: Colors.white),);
                case 15:
                  return const Text("15:00", style: TextStyle(color: Colors.white),);
                case 18:
                  return const Text("18:00", style: TextStyle(color: Colors.white),);
                case 21:
                  return const Text("21:00", style: TextStyle(color: Colors.white),);
                  // break;
                default:
                  return const SizedBox();
              }
            },
          )
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false,)
          
        ),
        topTitles:const  AxisTitles(
          axisNameSize: 30,
          axisNameWidget: Text(
            "Today temperatures",
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white
            ),
            ),
          sideTitles: SideTitles(showTitles: false)
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
          spots: List.generate(temperature.length, (index) => FlSpot(index.toDouble(), temperature[index])),
          isCurved: true,
          color:const Color.fromARGB(255, 31, 213, 21),
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index)=>FlDotCirclePainter(
                radius: 4,
                color: Colors.blue, // Change dot color conditionally
                strokeWidth: 2,
                strokeColor: Colors.white,
            ),
          ),
          // gradient:Gradient(colors: ),

        ),

      ]
    )
  );
}
