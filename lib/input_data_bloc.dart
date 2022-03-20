import 'package:age_calculator/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputDataBloc extends Cubit<InputDataStates> {
  InputDataBloc(_) : super(InputDataInitialState());
  DateTime dateOfBirth= DateTime(Constants.defaultDate);
  DateTime lastDate = DateTime.now();

  void addFirstDateOfBirthEvent(DateTime date) {
    print('date $date');
    dateOfBirth = date;
    emit(PickedDateState(dateOfBirth, lastDate));
    print('date2 $date');
  }
  void addSecondDateOfBirthEvent(DateTime date) {
    print('lastdate $date');
    lastDate = date;
    emit(PickedDateState(dateOfBirth, lastDate));
    print('lastdate2 $date');
  }

  void calculateAge(){
    double differenceInDays = lastDate.difference(dateOfBirth).inHours / 24;
    int years = (differenceInDays/365).round();
    print('calculated ${differenceInDays}, full years $years');
  }

}

abstract class InputDataStates extends Equatable {}

class InputDataInitialState extends InputDataStates {
  final DateTime lastDate = DateTime.now();

  InputDataInitialState();
  @override
  List<Object?> get props => [];
}

class PickedDateState extends InputDataStates {
  PickedDateState(this.dateOfBirth, this.lastDate);

  final DateTime dateOfBirth;
  final DateTime lastDate;
  @override
  List<Object?> get props => [dateOfBirth, lastDate];
}
class CalculatedDifference extends InputDataStates {
  CalculatedDifference(this.difference);

  @override
  List<Object?> get props => [];
  final difference;

}
