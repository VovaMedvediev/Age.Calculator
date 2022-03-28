import 'package:flutter/material.dart';

import 'constants.dart' as constants;
import 'input_data_bloc.dart';

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
