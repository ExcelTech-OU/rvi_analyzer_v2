import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SocialMediaIconBoxData {
  final String imageUrl;
  final void Function() onClickFun;
  final int id;
  final int selectedId;
  final void Function(int id) setId;

  SocialMediaIconBoxData(
      {required this.id,
      required this.selectedId,
      required this.setId,
      required this.imageUrl,
      required this.onClickFun});
}

class SocialMediaIconBox extends StatelessWidget {
  final SocialMediaIconBoxData data;
  const SocialMediaIconBox({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: CupertinoButton(
        disabledColor: Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        padding: const EdgeInsets.all(0),
        color: const Color.fromARGB(255, 219, 218, 218),
        onPressed: data.selectedId == 0
            ? () {
                data.setId(data.id);
                data.onClickFun();
              }
            : null,
        child: (data.selectedId != 0 && data.id == data.selectedId)
            ? const CupertinoActivityIndicator()
            : Image(
                image: AssetImage(data.imageUrl),
                width: 25,
                height: 25,
              ),
      ),
    );
  }
}
