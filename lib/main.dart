import 'package:flutter/material.dart';

import 'screens/home_page/home_page.dart';

void main() {
  runApp(const AgeCalculator());
}

class AgeCalculator extends StatelessWidget {
  const AgeCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
