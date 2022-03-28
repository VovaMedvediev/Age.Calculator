import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'age_model.dart';

class CalculatedBloc extends Cubit<CalculatedStates> {
  CalculatedBloc(AgeModel ageModel) : super(InitState()){
    ageModel.getCalculated();
    emit(CalculatedDifferenceState(ageModel));
  }

}

abstract class CalculatedStates extends Equatable {}
class InitState extends CalculatedStates{
  @override
  List<Object?> get props => [];
}
class CalculatedDifferenceState extends CalculatedStates {
  CalculatedDifferenceState(this.age);

  final AgeModel age;
  @override
  List<Object?> get props => [age];
}
