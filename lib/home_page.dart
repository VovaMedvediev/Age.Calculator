import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'input_data_bloc.dart';
import 'input_data_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Age Calculator')),
      body: BlocProvider(
        create: (BuildContext context) => InputDataBloc(),
        child: InputDataPage(),
      ),
    );
  }
}
