import 'dart:convert';
import 'package:pizzer_mobile/models/user_info_model.dart';
import 'package:http/http.dart';

class UserInfoRepository {
  String userInfoUrl = 'http://192.168.1.38:25567/api/user';

  Future<UserInfoModel> getUserInfo(String? token) async {
    String? queryParams = "?token=" + token.toString();

    Response response = await get(Uri.parse(userInfoUrl + queryParams));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return UserInfoModel.fromJson(result);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> updateUserInfo(int? id, String? name, String? phone) async {
    String Url = userInfoUrl + '/updateClient';
    Response resPut = await put(Uri.parse(Url),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(<String, dynamic>{
          "id": id,
          "name": name,
          "phones": phone,
        }));
    if (resPut.statusCode != 200) {
      throw Exception(resPut.reasonPhrase);
    }
  }
}
