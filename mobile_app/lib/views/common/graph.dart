import 'dart:math';

import 'package:charts_painter/chart.dart';
import 'package:flutter/material.dart';
import 'package:rvi_analyzer/views/common/line_chart.dart';

class LineChartScreen extends StatefulWidget {
  final double verticalAxisStep;
  final double horizontalAxisStep;
  final String horizontalAxisName;
  final String verticalAxisName;
  final List<BubbleValue<void>> values;

  const LineChartScreen(
      {Key? key,
      required this.verticalAxisStep,
      required this.horizontalAxisStep,
      required this.horizontalAxisName,
      required this.verticalAxisName,
      required this.values})
      : super(key: key);

  @override
  _LineChartScreenState createState() => _LineChartScreenState();
}

class _LineChartScreenState extends State<LineChartScreen> {
  double targetMax = 0;
  bool _showValues = false;
  bool _fillLine = false;
  bool _showLine = true;
  bool _stack = true;
  int minItems = 15;

  @override
  void initState() {
    super.initState();
  }

  // void _updateValues() {
  //   final Random _rand = Random();
  //   final double _difference = 2 + (_rand.nextDouble() * 15);

  //   targetMax =
  //       3 + (_rand.nextDouble() * _difference * 0.75) - (_difference * 0.25);
  //   for (int i = 0; i < minItems; i++) {
  //     _values.add(BubbleValue<void>(2 + _rand.nextDouble() * _difference));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: SizedBox(
        height: 150,
        child: LineChart(
          data: widget.values,
          dataToValue: (BubbleValue value) => value.max ?? value.min!,
          stack: false,
          height: MediaQuery.of(context).size.height * 0.4,
          itemColor: Theme.of(context)
              .colorScheme
              .secondary
              .withOpacity(_showLine ? 1.0 : 0.0),
          lineWidth: 2.0,
          chartItemOptions: BubbleItemOptions(
            maxBarWidth: _showLine ? 0.0 : 6.0,
            bubbleItemBuilder: (data) =>
                BubbleItem(color: [Colors.blue][data.listIndex]),
          ),
          smoothCurves: true,
          backgroundDecorations: [
            GridDecoration(
              horizontalLegendPosition: HorizontalLegendPosition.start,
              showVerticalGrid: true,
              showTopHorizontalValue: true,
              showVerticalValues: true,
              horizontalAxisUnit: widget.horizontalAxisName,
              showHorizontalValues: true,
              horizontalAxisStep: widget.horizontalAxisStep,
              verticalAxisStep: widget.verticalAxisStep,
              textStyle: const TextStyle(
                  fontSize: 7,
                  fontWeight: FontWeight.w300,
                  color: Colors.black),
              gridColor: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withOpacity(0.2),
            ),
            SparkLineDecoration(
              id: 'first_line_fill',
              smoothPoints: true,
              fill: true,
              lineColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(_fillLine
                      ? _stack
                          ? 1.0
                          : 0.2
                      : 0.0),
            )
          ],
          foregroundDecorations: [
            SparkLineDecoration(
              id: 'second_line',
              lineWidth: 2.0,
              smoothPoints: true,
              lineColor: Theme.of(context)
                  .colorScheme
                  .primary
                  .withOpacity(_showLine ? 1.0 : 0.0),
            )
          ],
        ),
      ),
    );
  }
}
