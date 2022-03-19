import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputDataBloc extends Cubit<InputDataStates> {
  InputDataBloc(_) : super(InputDataInitialState()) {}
  late DateTime dateOfBirth;
  late DateTime lastDate;

  void addFirstDateOfBirthEvent(DateTime date) {
    print('date $date');
    dateOfBirth = date;
    emit(pickedDateState(dateOfBirth, lastDate));
    print('date2 $date');
    // print('date3 $dateOfBirth');
  }
  void addSecondDateOfBirthEvent(DateTime date) {
    print('date $date');
    lastDate = date;
    emit(pickedDateState(dateOfBirth, lastDate));}
}

abstract class InputDataStates extends Equatable {}

class InputDataInitialState extends InputDataStates {
  @override
  List<Object?> get props => [];
}

class pickedDateState extends InputDataStates {
  pickedDateState(this.dateOfBirth, this.lastDate);

  final DateTime dateOfBirth;
  final DateTime lastDate;
  @override
  List<Object?> get props => [dateOfBirth, lastDate];
}
