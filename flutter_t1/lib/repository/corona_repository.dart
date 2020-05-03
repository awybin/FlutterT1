import 'dart:convert';

import 'package:flutter_t1/Model/corona_summary.dart';
import 'package:http/http.dart' as http;

class CoronaRepository {
  static var countryCode = {
    'Brasil': 'BR',
    'Estados Unidos': 'US',
    'Itália': "IT"
  };

  static Future<CoronaSummary> fetchAlbum() async {
    final response = await http.get('https://api.covid19api.com/summary');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return CoronaSummary.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load corona summary');
    }
  }

  static CountrySummary getSummaryFor(CoronaSummary data, String countryName) {
    return data.countries.firstWhere(
        (country) => country.countryCode == countryCode[countryName]);
  }
}
