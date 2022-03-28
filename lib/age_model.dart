class AgeModel {
  AgeModel(this.birthDate, this.toDate);

  DateTime birthDate;
  DateTime toDate;
  late final int differenceInSeconds;
  late final double years;
  late final double months;
  late final double days;

  getCalculated() {
    differenceInSeconds = toDate.difference(birthDate).inSeconds;
    years = differenceInSeconds / 365 / 3600 / 24;
    months = (years - years.floor()) * 12;
    days = (months - months.floor()) * 30;
  }
}
