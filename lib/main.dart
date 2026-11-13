import 'package:flutter/material.dart';

import 'screen/home_screen.dart';

void main() {
  runApp(const MiAplicacion());
}

class MiAplicacion extends StatelessWidget {
  const MiAplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Bitácora',

      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),

      home: const HomeScreen(),
    );
  }
}
