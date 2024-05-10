import 'package:crocs_club/data/sharedpreference/shared_preference.dart';
import 'package:crocs_club/domain/models/address_model.dart';
import 'package:dio/dio.dart';

class AdressServices {
  final Dio _dio = Dio();

  Future<Response<dynamic>> addAddress(AddressModel address) async {
    const url = 'https://crocs.crocsclub.shop/user/profile/addaddress';
    final token = await getToken();

    try {
      final response = await _dio.post(
        url,
        data: address.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response;
    } catch (error) {
      throw Exception('Failed to add address: $error');
    }
  }

  Future<Response<dynamic>> getUserAddresses() async {
    const url = 'https://crocs.crocsclub.shop/user/profile/address';
    final token = await getToken();

    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response;
    } catch (error) {
      throw Exception('Failed to retrieve user addresses: $error');
    }
  }
}
