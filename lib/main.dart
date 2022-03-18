import 'package:flutter/material.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading: const Text('Age Calculator')),
      body: const Center(
    child: Text('test text')
    )
    ,
    );
  }
}
