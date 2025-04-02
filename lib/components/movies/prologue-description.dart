import 'package:flutter/cupertino.dart';

class PrologoDescripcion {
  Widget GetPrologoDescripcion(VoidCallback ontapText, String text, int maxLines, bool isPrologo){
    return GestureDetector(
        onTap: ontapText,
        child: Text(text ?? "", maxLines: maxLines, overflow: TextOverflow.ellipsis, style: TextStyle (fontStyle: isPrologo ? FontStyle.italic: FontStyle.normal),)
    );
  }

}