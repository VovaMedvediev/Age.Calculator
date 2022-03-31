import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../input_data_page/input_data_bloc.dart';
import '../input_data_page/input_data_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    checkPermission();
    return Scaffold(
      appBar: AppBar(title: const Text('Age Calculator')),
      body: BlocProvider(
        create: (BuildContext context) => InputDataBloc(),
        child: InputDataPage(),
      ),
    );
  }

  checkPermission() async {
    var status = await Permission.notification.status;
    if (status.isDenied) {
      print('status1');
      var k = await Permission.notification.request();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }
    else if (status.isGranted){
      print('status2');
      await Permission.notification.request();
    }
    else if(status.isLimited){
      print('status3');

    }
    else if(status.isRestricted){
      print('status4');

    }

// You can can also directly ask the permission about its status.

  }

}