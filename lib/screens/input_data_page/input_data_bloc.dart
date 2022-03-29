import 'package:flutter_bloc/flutter_bloc.dart';
import '/age_model.dart';
import '/constants.dart' as constants;

class InputDataBloc extends Cubit<InputDataStates> {
  InputDataBloc() : super(InputDataInitialState());
  AgeModel ageModel = AgeModel(DateTime(constants.defaultDate), DateTime.now());

  void addDateEvent(AgeModel ageModel) {
    emit(PickedDateState(ageModel));
  }

  String getTextDate(String widgetName) {
    String textDate;
    if (widgetName == constants.fromDateNameString) {
      textDate = ageModel.birthDate.toString();
    } else {
      textDate = ageModel.toDate.toString();
    }
    if (textDate == DateTime(constants.defaultDate).toString()) {
      textDate = 'Pick up a date';
    }
    return textDate;
  }
}

abstract class InputDataStates {}

class InputDataInitialState extends InputDataStates {}

class PickedDateState extends InputDataStates {
  PickedDateState(this.ageModel);

  final AgeModel ageModel;
}
