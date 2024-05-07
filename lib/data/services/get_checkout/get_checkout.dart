import 'package:crocs_club/data/sharedpreference/shared_preference.dart';
import 'package:crocs_club/domain/models/checkout_details.dart';
import 'package:crocs_club/domain/models/order.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CheckOutServices {
  Future<CheckoutData> fetchCheckoutDetails() async {
    final authorizationToken = await getToken();
    final response = await http.get(
      Uri.parse('http://crocs.crocsclub.shop/user/check-out'),
      headers: {
        'accept': 'application/json',
        'Authorization': authorizationToken ?? "",
      },
    );

    if (response.statusCode == 200) {
      final parsedResponse = jsonDecode(response.body);
      final data = parsedResponse['data'];
      return CheckoutData.fromJson(data);
    } else {
      throw Exception('Failed to load checkout details');
    }
  }

  Future<int> placeOrder(
    OrderDetails orderDetails,
  ) async {
    final url = Uri.parse('http://crocs.crocsclub.shop/user/check-out/order');
    final authToken = await getToken();
    final headers = {
      'accept': 'application/json',
      'Authorization': authToken ?? '',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode(orderDetails.toJson());

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Handle success
      print('Order placed successfully');
      return response.statusCode;
    } else {
      print('Failed to place order: ${response.reasonPhrase}');

      return response.statusCode;
    }
  }
}
