import 'package:age_calculator/input_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatedDataPage extends StatefulWidget {
  const CalculatedDataPage({Key? key}) : super(key: key);

  @override
  State<CalculatedDataPage> createState() => _CalculatedDataPageState();
}

class _CalculatedDataPageState extends State<CalculatedDataPage> {
  @override
  Widget build(BuildContext context) {
    // final calculatedDifferenceState =
    //     context.read<InputDataBloc>().state as CalculatedDifference;
    return const Material(
        child: Center(child: Text('work in progres...')
        // Text(calculatedDifferenceState.difference),
        ));
  }
}
