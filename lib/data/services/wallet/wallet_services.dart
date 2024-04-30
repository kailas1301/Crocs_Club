import 'dart:convert';
import 'package:crocs_club/data/sharedpreference/shared_preference.dart';
import 'package:http/http.dart' as http;

class WalletServices {
  static Future<dynamic> getWallet() async {
    const url = "http://10.0.2.2:8080/user/wallet";
    final token = await getToken();

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      print("Wallet was successfully fetched");
      final responseData = json.decode(response.body);
      final walletAmount = responseData["data"]["amount"];
      print("wallet amoungt is $walletAmount");

      return walletAmount;
    } else {
      print("Wallet was not successfully fetched");
      throw Exception('Failed to fetch wallet data: ${response.statusCode}');
    }
  }
}
