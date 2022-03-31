import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/constants.dart' as constants;
import '../calculated_page/calculated_data_page.dart';
import 'date_pick_widget.dart';
import 'input_data_bloc.dart';

class InputDataPage extends StatelessWidget {
  InputDataPage({Key? key}) : super(key: key);
  final InputDataBloc _bloc = InputDataBloc();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 15),
          BlocBuilder<InputDataBloc, InputDataStates>(
            bloc: _bloc,
            builder: (context, state) {
              if (state is InputDataInitialState) {
                return Column(
                  children: [
                    DatePick(
                      widgetName: constants.fromDateNameString,
                      bloc: _bloc,
                    ),
                    const SizedBox(height: 15),
                    DatePick(
                      widgetName: constants.toDateNameString,
                      bloc: _bloc,
                    ),
                  ],
                );
              } else if (state is PickedDateState) {
                return Column(
                  children: [
                    DatePick(
                      widgetName: constants.fromDateNameString,
                      bloc: _bloc,
                    ),
                    const SizedBox(height: 15),
                    DatePick(
                      widgetName: constants.toDateNameString,
                      bloc: _bloc,
                    ),
                  ],
                );
              } else {
                return const Text('Unknown error');
              }
            },
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              if (_bloc.ageModel.birthDate != DateTime(constants.defaultDate)) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalculatedDataPage(_bloc.ageModel),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Fill in the From date field!'),
                  ),
                );
              }
            },
            child: const Text('Calculate Age'),
          )
        ],
      ),
    );
  }
}
