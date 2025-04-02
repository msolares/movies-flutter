// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Load {
  Widget GetLoad (String text, bool visible, Size size){
    return Visibility(
      visible:  visible,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
             child: Container(
               width: size.width / 1.5,
               height: size.width / 1.5,
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.all(Radius.circular(10)),
               ),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   CircularProgressIndicator(),
                   Padding(
                     padding: const EdgeInsets.all(16.0),
                     child: Text(text, style: TextStyle(fontFamily: "Glow Mind", fontSize: 18),overflow: TextOverflow.ellipsis,),
                   )
                 ],
               ),
            ),
          ),
        ),
      );
    }
}