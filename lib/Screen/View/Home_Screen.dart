import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locater/Screen/Controller/location_controller.dart';
import 'package:multilevel_drawer/multilevel_drawer.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LocationController lcontroller = Get.put(LocationController());

  @override
  void initState() {
    super.initState();
    lcontroller.CheckPermission();
    lcontroller.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Location tracker",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (context) {
              return IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ));
            }
          ),
          actions: [
            IconButton(onPressed: (){},icon: Icon(Icons.search,color: Colors.black,)),
          ],
        ),
        body: Obx(
          () => GoogleMap(
            onMapCreated: (controller) {
              lcontroller.completer.value.complete(controller);
            },
            initialCameraPosition: CameraPosition(
                target: lcontroller.c.value, zoom: 11, tilt: 0, bearing: 0),
            // compassEnabled: true,
            mapType:lcontroller.m.value,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: lcontroller.Markers(),
          ),
        ),
        drawer: MultiLevelDrawer(
          header: Column(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/r.png"),fit: BoxFit.fill
                  )
                ),
              ),
              Text("Kaushik Ahir",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
            ],
          ),
          children: [
            MLMenuItem(
              leading: Icon(Icons.person),
              content: Text(
                "My Profile",
              ),
              onClick: () {},
            ),
            MLMenuItem(
              leading: Icon(Icons.notifications),
              content: Text("Notifications"),
              onClick: () {},
            ),
            MLMenuItem(
                leading: Icon(Icons.ac_unit_sharp),
                trailing: Icon(Icons.arrow_right),
                content: Text(
                  "Permission",
                ),
                subMenuItems: [
                  MLSubmenu(onClick: () async {
                    var status = await Permission.camera.status;
                    if(status.isDenied)
                    {
                      Permission.camera.request();
                    }
                  }, submenuContent: Text("Camera Permission")),
                  MLSubmenu(onClick: () async {
                    var status = await Permission.storage.status;
                    if(status.isDenied)
                    {
                      Permission.storage.request();
                    }
                  }, submenuContent: Text("Storage Permission")),
                  MLSubmenu(onClick: () async {
                    var status = await Permission.location.status;
                    if(status.isDenied)
                    {
                      Permission.location.request();
                    }
                  }, submenuContent: Text("Location Permission")),
                ],
                onClick: () {}),  MLMenuItem(
                leading: Icon(Icons.map),
                trailing: Icon(Icons.arrow_right),
                content: Text("Change Map"),
                onClick: () {},
                subMenuItems: [
                  MLSubmenu(onClick: () {
                    lcontroller.m.value=lcontroller.l1[0];
                    Get.back();
                  }, submenuContent: Text("normal")),
                  MLSubmenu(onClick: () {
                    lcontroller.m.value=lcontroller.l1[1];
                    Get.back();
                  }, submenuContent: Text("hybrid")),
                  MLSubmenu(onClick: () {
                    lcontroller.m.value=lcontroller.l1[2];
                    Get.back();
                  }, submenuContent: Text("satellite")),
                  MLSubmenu(onClick: () {
                    lcontroller.m.value=lcontroller.l1[3];
                    Get.back();
                  }, submenuContent: Text("none")),
                  MLSubmenu(onClick: () {
                    lcontroller.m.value=lcontroller.l1[4];
                    Get.back();
                  }, submenuContent: Text("terrain")),
                ]),
            MLMenuItem(
                leading: Icon(Icons.settings),
                trailing: Icon(Icons.arrow_right),
                content: Text("Settings"),
                onClick: () {},
                subMenuItems: [
                  MLSubmenu(onClick: () {
                    openAppSettings();
                  }, submenuContent: Text("Open Setting")),
                ],),
          ],
        ),
      ),
    );
  }
}
