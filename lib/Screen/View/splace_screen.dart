import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplaceScreen extends StatefulWidget {
  const SplaceScreen({Key? key}) : super(key: key);

  @override
  State<SplaceScreen> createState() => _SplaceScreenState();
}

class _SplaceScreenState extends State<SplaceScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3),()=> Get.offAllNamed('home'));
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Spacer(),
              Image.asset('assets/images/m.png',height: 300,width: 300,),
              Spacer(),
              Text('From',style: TextStyle(fontSize: 16,color: Colors.grey,fontWeight: FontWeight.w500),),
              SizedBox(height: 5),
              Text('Kaushik Ahir',style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
