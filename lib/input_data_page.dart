import 'package:age_calculator/calculated_data_page.dart';
import 'package:age_calculator/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'input_data_bloc.dart';
import 'constants.dart';

class InputDataPage extends StatefulWidget {
  @override
  State<InputDataPage> createState() => _InputDataPageState();
}

class _InputDataPageState extends State<InputDataPage> {
  final InputDataBloc _bloc = InputDataBloc(InputDataInitialState());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InputDataBloc>(
        create: (BuildContext context) => _bloc,
        child: Padding(
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
                        datePick(Constants.fromDateNameString,
                            DateTime(Constants.defaultDate)),
                        const SizedBox(height: 15),
                        datePick(Constants.toDateNameString, state.lastDate),
                      ]);
                    } else if (state is PickedDateState) {
                      return Column(children: [
                        datePick(Constants.fromDateNameString, state.dateOfBirth),
                        const SizedBox(height: 15),
                        datePick(Constants.toDateNameString, state.lastDate),
                      ]);
                    } else {
                      return const Text('Unknown error');
                    }
                  }),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (_bloc.dateOfBirth != DateTime(0000)) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CalculatedDataPage()));
                    _bloc.calculateAge();
                  } else {
                    showPicker(Constants.fromDateNameString);
                  }
                },
                child: const Text('Calculate Age'),
              )
            ],
          ),
        ));
  }

  Widget datePick(String widgetName, DateTime pick) {
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
                      showPicker(widgetName).then((date) {
                        if (widgetName == Constants.fromDateNameString) {
                          _bloc.addFirstDateOfBirthEvent(date!);
                        } else if (widgetName == Constants.toDateNameString) {
                          _bloc.addSecondDateOfBirthEvent(date!);
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

  Future<DateTime?> showPicker(String widgetName) {
    return showDatePicker(
        context: context,
        initialDate: widgetName == 'Date of Birth (From)'
            ? DateTime.utc(2000)
            : DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
  }
}
