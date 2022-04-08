import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../input_data_page/input_data_bloc.dart';
import '../input_data_page/input_data_page.dart';
import '../settings_page/settings.dart';
import '../settings_page/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Settings.checkPermission();
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) => Scaffold(
        appBar: AppBar(
          title: const Text('Age Calculator'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              ),
            )
          ],
        ),
        body: BlocProvider(
          create: (BuildContext context) => InputDataBloc(),
          child: InputDataPage(),
        ),
      ),
    );
  }
}
