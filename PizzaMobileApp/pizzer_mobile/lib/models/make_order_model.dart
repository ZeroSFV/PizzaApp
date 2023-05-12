class MakeOrderModel {
  int? clientId;
  String? address;
  String? phoneNumber;
  String? clientName;
  String? payingType;
  DateTime? predictedTime;
  int? change;
  int? usedBonuses;
  int? givenBonuses;
  String? comment;

  MakeOrderModel(
      {this.clientId,
      this.address,
      this.phoneNumber,
      this.clientName,
      this.payingType,
      this.predictedTime,
      this.change,
      this.usedBonuses,
      this.givenBonuses,
      this.comment});
}
