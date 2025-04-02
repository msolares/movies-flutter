import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Arrowup {
  Widget GetArrowUp(VoidCallback onTap, bool visible) {
    return  GestureDetector(
        onTap: onTap,
        child: Text (visible ? 'ver menos': 'ver más')
    );
  }
}