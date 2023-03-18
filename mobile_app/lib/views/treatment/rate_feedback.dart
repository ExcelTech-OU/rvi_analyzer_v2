import 'package:rvi_analyzer/domain/question_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateCustomForFeedback extends StatefulWidget {
  final RateDataForFeedback rateDataForFeedback;
  const RateCustomForFeedback(this.rateDataForFeedback, {Key? key})
      : super(key: key);

  @override
  State<RateCustomForFeedback> createState() =>
      _RateCustomForFeedbackState(rateDataForFeedback);
}

class _RateCustomForFeedbackState extends State<RateCustomForFeedback> {
  late RateDataForFeedback rateDataForFeedback;
  int selectedIndex = -1;

  LinearGradient gradient = const LinearGradient(
      colors: <Color>[Colors.red, Colors.orange, Colors.yellow, Colors.green]);

  double painLevel = 0;
  _RateCustomForFeedbackState(this.rateDataForFeedback);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Divider(
          thickness: 2,
          color: Color.fromARGB(255, 97, 97, 97),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 0, 10),
            child: Text(
              rateDataForFeedback.questionResponse.question.question,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 30, 41, 59),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    RatingBarIndicator(
                      itemSize: 25,
                      itemCount: 5,
                      rating: painLevel / 2,
                      itemPadding: const EdgeInsets.fromLTRB(8, 0, 34, 10),
                      direction: Axis.horizontal,
                      unratedColor: Colors.grey,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return const Icon(
                              Icons.sentiment_very_dissatisfied,
                              color: Colors.red,
                            );
                          case 1:
                            return const Icon(
                              Icons.sentiment_dissatisfied,
                              color: Color.fromARGB(255, 213, 100, 100),
                            );
                          case 2:
                            return const Icon(
                              Icons.sentiment_neutral,
                              color: Colors.amber,
                            );
                          case 3:
                            return const Icon(
                              Icons.sentiment_satisfied,
                              color: Colors.lightGreen,
                            );
                          case 4:
                            return const Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.green,
                            );
                          default:
                            return const Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.green,
                            );
                        }
                      },
                    ),
                  ],
                ),
                // SliderTheme(
                //   data: SliderThemeData(
                //     overlayShape: SliderComponentShape.noOverlay,
                //     trackShape: GradientRectSliderTrackShape(
                //         gradient: gradient, darkenInactive: true),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Slider(
                //       value: painLevel,
                //       onChanged: (newLevel) {
                //         setState(() {
                //           painLevel = newLevel;
                //         });

                //         rateDataForFeedback.onUpdate(rateDataForFeedback.index,
                //             (painLevel).round().toString());
                //       },
                //       min: 0,
                //       max: 10,
                //       divisions: 100,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      )
    ]);
  }
}

class RateDataForFeedback {
  final QuestionResponse questionResponse;
  final int index;
  final void Function(int index, String val) onUpdate;

  RateDataForFeedback(this.questionResponse, this.index, this.onUpdate);
}
