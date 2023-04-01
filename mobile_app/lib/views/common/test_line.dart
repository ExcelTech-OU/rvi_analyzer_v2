import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartDataCustom {
  String yAxisName;
  String xAxisName;
  double xMin;
  double xMax;
  double yMin;
  double yMax;
  double xInterval;
  double yInterval;
  List<FlSpot> spotData;
  LineChartDataCustom(
      {required this.xAxisName,
      required this.spotData,
      required this.xMax,
      required this.xMin,
      required this.yAxisName,
      required this.yMax,
      required this.yMin,
      required this.xInterval,
      required this.yInterval});
}

class LineChartSample2 extends StatefulWidget {
  LineChartDataCustom data;
  LineChartSample2({Key? key, required this.data}) : super(key: key);

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          height: 175,
          child: LineChart(
            mainData(),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 8,
    );

    return Text(value.toStringAsFixed(2),
        style: style, textAlign: TextAlign.left);
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 8,
    );

    return Text(value.toStringAsFixed(2),
        style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.amber,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.blueGrey,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          axisNameWidget: Text(
            widget.data.xAxisName,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: widget.data.xInterval,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          axisNameWidget: Text(
            widget.data.yAxisName,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          sideTitles: SideTitles(
            showTitles: true,
            interval: widget.data.yInterval,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: widget.data.xMin,
      maxX: widget.data.xMax,
      minY: widget.data.yMin,
      maxY: widget.data.yMax,
      lineBarsData: [
        LineChartBarData(
          spots: widget.data.spotData,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
