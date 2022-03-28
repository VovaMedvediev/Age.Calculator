import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants.dart' as constants;

class InputDataBloc extends Cubit<InputDataStates> {
  InputDataBloc(_) : super(InputDataInitialState());
  DateTime dateOfBirth = DateTime(constants.defaultDate);
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
    final years = differenceInSeconds! / 365 / 3600 / 24;
    final months = (years - years.floor()) * 12;
    final days = (months - months.floor()) * 30;
    print(
        'calculated ${differenceInSeconds}, full years $years, months $months, days $days');
    emit(CalculatedDifferenceState(
        differenceInSeconds, years.floor(), months.floor(), days.floor()));
  }
}

abstract class InputDataStates extends Equatable {}

class InputDataInitialState extends InputDataStates {
  final DateTime lastDate = DateTime.now();

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
  final difference;
  final int years;
  final int months;
  final int days;

  CalculatedDifferenceState(
      this.difference, this.years, this.months, this.days) {}

  @override
  List<Object?> get props => [difference];
}
