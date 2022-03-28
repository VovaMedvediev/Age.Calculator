import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'age_model.dart';
import 'calculated_bloc.dart';

class CalculatedDataPage extends StatefulWidget {
  const CalculatedDataPage(this.ageModel) : super();
  final AgeModel ageModel;

  @override
  State<CalculatedDataPage> createState() => _CalculatedDataPageState();
}

class _CalculatedDataPageState extends State<CalculatedDataPage> {
  @override
  Widget build(BuildContext context) {
    print(
        'fromSecondPage ${widget.ageModel.birthDate} ${widget.ageModel.toDate}');
    return Material(
      child: BlocProvider<CalculatedBloc>(
        lazy: false,
        create: (BuildContext context) => CalculatedBloc(widget.ageModel),
        child: BlocBuilder<CalculatedBloc, CalculatedStates>(
          // bloc: BlocProvider.of<CalculatedBloc>(context),
          builder: (context, state) {
            print('state $state');
            if (state is CalculatedDifferenceState) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('You have been living ${state.age.differenceInSeconds} '
                      'seconds from the birth'),
                  Text(
                    'Your age is: ${state.age.years} years old, '
                    '${state.age.months} months, ${state.age.days} days',
                  )
                ],
              ));
            } else {
              return const Center(child: Text('Unknown error2'));
            }
          },
        ),
      ),
    );
  }
}
