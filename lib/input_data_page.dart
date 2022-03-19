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
    return BlocProvider<InputDataBloc>(
        create: (BuildContext context) => _bloc,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 15),
              BlocBuilder<InputDataBloc, InputDataStates>(
                  bloc: _bloc,
                  builder: (context, state) {
                    print('state $state');
                    if (state is InputDataInitialState) {
                      return Column(children: [
                        datePick('Date of Birth', null),
                        datePick("Today's date", null),
                      ]);
                    } else if (state is pickedDateState) {
                      return Column(children: [
                        datePick('Date of Birth', state.dateOfBirth),
                        datePick("Today's date", state.lastDate),
                      ]);
                    } else
                      return Text('Unknown error');
                  }),
              const ElevatedButton(
                onPressed: null,
                child: Text('Calculate Age'),
              )
            ],
          ),
        ));
  }

  Widget datePick(String widgetName, DateTime? pick) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text('$widgetName'),
          const SizedBox(
            width: 25,
          ),
          InkWell(
              onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: pick ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2040))
                    .then((date) {
                 if(widgetName == 'Date of Birth') {
                    _bloc.addFirstDateOfBirthEvent(date!);
                  } else if (widgetName == "Today's date"){
                   _bloc.addSecondDateOfBirthEvent(date!);
                 }
                });
              },
              child: Text(pick == null
                  ? 'Nothing was picked'
                  : pick.toString())),
        ],
      ),
    );
  }
}
