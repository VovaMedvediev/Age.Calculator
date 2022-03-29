import 'package:flutter_bloc/flutter_bloc.dart';
import '/age_model.dart';
import '/constants.dart' as constants;

class InputDataBloc extends Cubit<InputDataStates> {
  InputDataBloc() : super(InputDataInitialState());
  AgeModel ageModel = AgeModel(DateTime(constants.defaultDate), DateTime.now());

  void addDateEvent(AgeModel ageModel) {
    emit(PickedDateState(ageModel));
    print('age model ${ageModel.birthDate} ${ageModel.toDate}');
  }
}

abstract class InputDataStates {}

class InputDataInitialState extends InputDataStates {

}

class PickedDateState extends InputDataStates {
  PickedDateState(this.ageModel);

  final AgeModel ageModel;

}
