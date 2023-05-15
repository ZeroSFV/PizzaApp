import 'dart:convert';
import 'package:pizzer_mobile/models/sign_in_response_model.dart';
import 'package:http/http.dart';

class AccountRepository {
  String accountUrl = 'http://192.168.1.38:25567/api/account';

  Future<bool> changeUserPassword(
      String? token, String? oldPassword, String? newPassword) async {
    String Url = accountUrl + '/changepassword';

    Response resPut = await put(Uri.parse(Url),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(<String, dynamic>{
          "oldPassword": oldPassword,
          "newPassword": newPassword,
          "token": token,
        }));
    if (resPut.statusCode == 200)
      return true;
    else if (resPut.statusCode == 400) {
      return false;
    } else {
      throw Exception(resPut.reasonPhrase);
    }
  }

  Future<void> approveUser(int? id, String? approvalCode) async {
    String Url = accountUrl + '/approveUser';

    Response resPut = await put(Uri.parse(Url),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(<String, dynamic>{
          "id": id,
          "approvalCode": approvalCode,
        }));
    if (resPut.statusCode != 200) throw Exception(resPut.reasonPhrase);
  }

  Future<bool> resetPassword(String? email) async {
    String Url = accountUrl + '/resetpassword';

    Response resPut = await put(Uri.parse(Url),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(<String, dynamic>{
          "email": email,
        }));
    if (resPut.statusCode == 200)
      return true;
    else if (resPut.statusCode == 400) {
      return false;
    } else {
      throw Exception(resPut.reasonPhrase);
    }
  }

  Future<bool> register(String? email, String? name, String? phone,
      String? password, String? repeatPassword) async {
    String Url = accountUrl + '/signUp';
    Response resPost = await post(Uri.parse(Url),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(<String, dynamic>{
          "email": email,
          "name": name,
          "phone": phone,
          "password": password,
          "repeatPassword": repeatPassword
        }));
    if (resPost.statusCode == 200)
      return true;
    else if (resPost.statusCode == 400) {
      return false;
    } else {
      throw Exception(resPost.reasonPhrase);
    }
  }

  Future<SignInResponseModel> signIn(String? email, String? password) async {
    String Url = accountUrl + '/signIn';

    Response resPost = await post(Uri.parse(Url),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(<String, dynamic>{
          "email": email,
          "password": password,
        }));
    if (resPost.statusCode == 200) {
      final result = jsonDecode(resPost.body);
      final reqResult = SignInResponseModel.fromJson(result);
      reqResult.responseCode = 200;
      return reqResult;
    } else if (resPost.statusCode == 401) {
      final reqResult = SignInResponseModel(refreshToken: "", jwTtoken: "");
      reqResult.responseCode = resPost.statusCode;
      return reqResult;
    } else {
      throw Exception(resPost.reasonPhrase);
    }
  }
}
