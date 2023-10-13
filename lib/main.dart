import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final sharedPrefs = await SharedPreferences.getInstance();

  runApp(AppWidget(sharedPreferences: sharedPrefs));
}