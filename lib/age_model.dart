class AgeModel {
  AgeModel(this.birthDate, this.toDate);

  DateTime birthDate;
  DateTime toDate;
  late int differenceInSeconds;
  late double years;
  late double months;
  late double days;

  void getCalculated() {
    differenceInSeconds = toDate.difference(birthDate).inSeconds;
    years = differenceInSeconds / 365 / 3600 / 24;
    months = (years - years.floor()) * 12;
    days = (months - months.floor()) * 30;
  }
}
