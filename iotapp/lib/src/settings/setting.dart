import 'package:flutter/material.dart';

class Setting {
  static const double paddingSmall = 12.0;
  static const double paddingMedium = 20.0;
  static const double paddingLarge = 200.0;

  static const double sizeSmall = 50.0;
  static const double sizeMedium = 75.0;
  static const double sizeLarge = 150.0;
  static const double sizeFull = double.infinity;

  static const Color activeColor = Color.fromARGB(255, 0, 140, 0);
  static const Color disableColor = Color.fromARGB(255, 140, 0, 0);

//API
  static const String API_URL ="https://iot-data-engineers-server.onrender.com/api";
   
  static const String EQUIPMENTS_ENDPOINT = "equipments";
  static const String HOUSES_ENDPOINT = "houses";
  static const String ROOMS_ENDPOINT = "rooms";
  static const String HOUSE_ID = "KEVIN";

}