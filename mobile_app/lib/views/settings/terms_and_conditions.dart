import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Terms & Conditions',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
            child: Column(
              children: const [
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Dui accumsan eget fringilla nulla ullamcorper phasellus nullam et. Sed at volutpat a mauris vel maecenas. Nunc massa dui tellus vehicula et fermentum malesuada. Ac vitae nisl nisl, praesent cras. Morbi lacus nisi, pulvinar nulla id. Enim leo sed leo non.",
                  style: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 148, 163, 184)),
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Dui accumsan eget fringilla nulla ullamcorper phasellus nullam et. Sed at volutpat a mauris vel maecenas. Nunc massa dui tellus vehicula et fermentum malesuada. Ac vitae nisl nisl, praesent cras. Morbi lacus nisi, pulvinar nulla id. Enim leo sed leo non.",
                  style: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 148, 163, 184)),
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Dui accumsan eget fringilla nulla ullamcorper phasellus nullam et. Sed at volutpat a mauris vel maecenas. Nunc massa dui tellus vehicula et fermentum malesuada. Ac vitae nisl nisl, praesent cras. Morbi lacus nisi, pulvinar nulla id. Enim leo sed leo non.",
                  style: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 148, 163, 184)),
                )
              ],
            )),
      ),
    );
  }
}
