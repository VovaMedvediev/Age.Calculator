import 'calculated_data_page.dart';
import 'constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'input_data_bloc.dart';

class InputDataPage extends StatefulWidget {
  @override
  State<InputDataPage> createState() => _InputDataPageState();
}

class _InputDataPageState extends State<InputDataPage> {
  final InputDataBloc _bloc = InputDataBloc(InputDataInitialState());

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
                  return Column(children: [
                    DatePick(
                        widgetName: Constants.fromDateNameString,
                        pick: DateTime(Constants.defaultDate),
                        bloc: _bloc),
                    const SizedBox(height: 15),
                    DatePick(
                        widgetName: Constants.toDateNameString,
                        pick: state.lastDate,
                        bloc: _bloc),
                  ]);
                } else if (state is PickedDateState) {
                  return Column(children: [
                    DatePick(
                        widgetName: Constants.fromDateNameString,
                        pick: state.dateOfBirth,
                        bloc: _bloc),
                    const SizedBox(height: 15),
                    DatePick(
                        widgetName: Constants.toDateNameString,
                        pick: state.lastDate,
                        bloc: _bloc),
                  ]);
                } else {
                  return const Text('Unknown error');
                }
              }),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              if (_bloc.dateOfBirth != DateTime(0000)) {
                _bloc.calculateAge();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                              value: _bloc,
                              child: CalculatedDataPage(),
                            )));
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
  const DatePick(
      {required this.widgetName, required this.pick, required this.bloc});

  final String widgetName;
  final DateTime pick;
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
              color: Colors.black,
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
                        if (widgetName == Constants.fromDateNameString) {
                          bloc.addFirstDateOfBirthEvent(date!);
                        } else if (widgetName == Constants.toDateNameString) {
                          bloc.addSecondDateOfBirthEvent(date!);
                        }
                      });
                    },
                    child: Text(pick == DateTime(Constants.defaultDate)
                        ? 'Pick up a date'
                        : pick.toString())),
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
        initialDate: widgetName == 'Date of Birth (From)'
            ? DateTime.utc(2000)
            : DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
  }
}
