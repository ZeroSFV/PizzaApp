class UserInfoModel {
  int? id;
  String? email;
  String? name;
  String? role;
  bool? isApproved;
  String? phone;
  int? bonuses;
  String? passport;

  UserInfoModel(
      {this.id,
      this.email,
      this.name,
      this.role,
      this.isApproved,
      this.phone,
      this.bonuses,
      this.passport});

  UserInfoModel.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    role = json['role'];
    isApproved = json['isApproved'];
    phone = json['phone'];
    bonuses = json['bonuses'];
    passport = json['passport'];
  }
}
