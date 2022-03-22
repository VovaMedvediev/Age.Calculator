import 'package:age_calculator/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputDataBloc extends Cubit<InputDataStates> {
  InputDataBloc(_) : super(InputDataInitialState());
  DateTime dateOfBirth = DateTime(Constants.defaultDate);
  DateTime lastDate = DateTime.now();
  int? differenceInSeconds;

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

  void calculateAge() {
    differenceInSeconds = lastDate.difference(dateOfBirth).inSeconds;
    double years = (differenceInSeconds! / 365 / 3600 / 24);
    double months = (years - years.floor()) * 12;
    double days = (months - months.floor()) * 30;
    print('calculated ${differenceInSeconds}, full years $years, months $months, days $days');
    emit(CalculatedDifferenceState(differenceInSeconds));
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

class CalculatedDifferenceState extends InputDataStates {
  CalculatedDifferenceState(this.difference);

  @override
  List<Object?> get props => [difference];
  final difference;
}
