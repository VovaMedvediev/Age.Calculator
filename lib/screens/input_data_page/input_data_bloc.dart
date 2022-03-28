import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../age_model.dart';
import '../../constants.dart' as constants;

class InputDataBloc extends Cubit<InputDataStates> {
  InputDataBloc() : super(InputDataInitialState());
  AgeModel ageModel = AgeModel(DateTime(constants.defaultDate), DateTime.now());

  void addDateEvent() {
    emit(PickedDateState(ageModel));
  }
}

abstract class InputDataStates extends Equatable {}

class InputDataInitialState extends InputDataStates {
  @override
  List<Object?> get props => [];
}

class PickedDateState extends InputDataStates {
  PickedDateState(this.age);

  final AgeModel age;

  @override
  List<Object?> get props => [age];
}
