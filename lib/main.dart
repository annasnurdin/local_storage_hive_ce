import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:local_storage_hive_ce/home_page.dart';

void main() async {
  //init HIVE
  await Hive.initFlutter();
  //open BOX (database)
  await Hive.openBox(
      "box_database"); //harus sama dengan di Hive.box("box_database");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Storage - Hive CE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
