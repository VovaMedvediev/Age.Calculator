import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'age_model.dart';
import 'calculated_data_page.dart';
import 'constants.dart' as constants;
import 'input_data_bloc.dart';

class InputDataPage extends StatelessWidget {
  InputDataPage({Key? key}) : super(key: key);
  final AgeModel ageModel = AgeModel(DateTime(0000), DateTime.now());
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
              print('state $state');
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
                print('age ${state.age.birthDate} ${state.age.toDate}');
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
              if (_bloc.ageModel.birthDate != DateTime(0000)) {
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

class DatePick extends StatelessWidget {
  const DatePick({required this.widgetName, required this.bloc});

  final String widgetName;
  final InputDataBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widgetName, style: const TextStyle(fontSize: 17)),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 3,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(
                  width: 25,
                ),
                InkWell(
                  onTap: () {
                    _showPicker(context, widgetName).then((date) {
                      if (widgetName == constants.fromDateNameString) {
                        bloc.ageModel.birthDate = date!;
                      } else {
                        bloc.ageModel.toDate = date!;
                      }
                      print(
                        'after showpicker ${bloc.ageModel.birthDate}'
                        ' ${bloc.ageModel.toDate}',
                      );
                      bloc.addDateEvent();
                    });
                  },
                  child: Text(
                    widgetName == constants.fromDateNameString
                        ? bloc.ageModel.birthDate.toString()
                        : bloc.ageModel.toDate.toString(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<DateTime?> _showPicker(BuildContext context, String widgetName) {
    return showDatePicker(
      context: context,
      initialDate: widgetName == constants.fromDateNameString
          ? DateTime(2000)
          : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
  }
}
