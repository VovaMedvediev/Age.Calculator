import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/age_model.dart';
import '/constants.dart' as constants;

class InputDataBloc extends Cubit<InputDataStates> {
  InputDataBloc() : super(InputDataInitialState());
  AgeModel ageModel = AgeModel(DateTime(constants.defaultDate), DateTime.now());

  void addDateEvent(AgeModel ageModel) {
    final listAge = <AgeModel>[];
    listAge.add(ageModel);
    emit(PickedDateState(List.of(listAge)));
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

abstract class InputDataStates extends Equatable {}

class InputDataInitialState extends InputDataStates {
  @override
  List<Object?> get props => [];
}

class PickedDateState extends InputDataStates {
  PickedDateState(this.listAge);

  final List<AgeModel> listAge;

  // final AgeModel ageModel;

  @override
  List<Object?> get props => [listAge];
}
