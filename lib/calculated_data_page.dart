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
    return Material(
      child: BlocBuilder<InputDataBloc, InputDataStates>(
          bloc: BlocProvider.of(context),
          builder: (context, state) {
            print('state $state');
            if (state is CalculatedDifferenceState) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'You have been living ${state.difference} seconds from the birthdate'),
                  Text(
                      'Your age is: ${state.years} years old, ${state.months} months, ${state.days} days'),
                ],
              ));
            } else {
              return const Center(child: Text('Unknown error'));
            }
          }),
    );
  }
}
