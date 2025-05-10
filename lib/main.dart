// main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/inspection_viewmodel.dart';
import 'view/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InspectionViewModel()..loadInspectionItems(),
      child: MaterialApp(
        title: 'Site Inspection App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeScreen(),
      ),
    );
  }
}
