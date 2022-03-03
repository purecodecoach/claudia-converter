import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/rate.dart';
import '../model/rate_crypto.dart';

class Api {
  static const baseEndpoint = 'https://api.exchangerate.host';

  static const baseCryptoEndpoint = 'https://rest.coinapi.io';
  static const headerCrypto = {
    'Content-type': 'application/json',
    'Accept': "application/json",
    'Accept-Encoding': "application/gzip"
  };
  // Get your own API key from CoinAPI - https://www.coinapi.io/
  static const apiKey = '73BD01A9-9850-4C81-8060-1F52D583473A';
  var client = new http.Client();

  Future<double> fetchRates(String base, String symbol) async {
    var response = await client.get(
      Uri.encodeFull('$baseEndpoint/latest?base=$base&symbols=$symbol'),
      // Uri.encodeFull('$baseEndpoint/latest?base=$base&symbols=$symbol'),
      // headers: header,
    );

    print('response: ${response.request} ${response.statusCode}');
    print(
        'rate: ${Rate.fromJson(json.decode(response.body), symbol).rates.gbp}');

    return Rate.fromJson(json.decode(response.body), symbol).rates.gbp;
  }

  Future<double> fetchRateCrypto(String base, String symbol) async {
    var response = await client.get(
      Uri.encodeFull(
          '$baseCryptoEndpoint/v1/exchangerate/$base/$symbol?apiKey=$apiKey'),
      headers: headerCrypto,
    );

    return RateCrypto.fromJson(json.decode(response.body)).rate;
  }
}
