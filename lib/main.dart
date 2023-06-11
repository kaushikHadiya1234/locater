import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:locater/Screen/View/Home_Screen.dart';
import 'package:locater/Screen/View/splace_screen.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(p0) =>SplaceScreen(),
        'home':(p0) =>HomeScreen(),
      },
    ),
  );
}
