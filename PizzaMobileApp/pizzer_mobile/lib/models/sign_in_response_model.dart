class SignInResponseModel {
  String? refreshToken;
  String? jwTtoken;
  int? responseCode;

  SignInResponseModel({this.refreshToken, this.jwTtoken});

  SignInResponseModel.fromJson(dynamic json) {
    refreshToken = json['refreshToken'];
    jwTtoken = json['jwTtoken'];
  }
}
