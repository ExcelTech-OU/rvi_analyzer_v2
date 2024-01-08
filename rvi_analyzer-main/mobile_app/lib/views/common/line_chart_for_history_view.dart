import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartHistoryData {
  String yAxisName;
  String xAxisName;
  List<FlSpot> spotData;
  LineChartHistoryData(
      {required this.xAxisName,
      required this.spotData,
      required this.yAxisName});
}

class LineChartHistory extends StatefulWidget {
  LineChartHistoryData data;
  LineChartHistory({Key? key, required this.data}) : super(key: key);

  @override
  State<LineChartHistory> createState() => _LineChartHistoryState();
}

class _LineChartHistoryState extends State<LineChartHistory> {
  List<Color> gradientColors = [
    Colors.red,
    Colors.red,
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
      lineTouchData: LineTouchData(
          getTouchLineEnd: (barData, spotIndex) => 0,
          getTouchLineStart: (barData, spotIndex) => 0,
          touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Colors.cyan,
              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                return touchedSpots.map((LineBarSpot touchedSpot) {
                  const textStyle = TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  );
                  return LineTooltipItem(touchedSpot.y.toString(), textStyle);
                }).toList();
              })),
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
            reservedSize: 10,
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
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 25,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: widget.data.spotData,
          isCurved: false,
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
