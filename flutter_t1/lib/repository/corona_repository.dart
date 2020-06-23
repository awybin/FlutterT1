import 'dart:convert';

import 'package:flutter_t1/Model/corona_summary.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class CoronaRepository {
  static Map<String, String> countryCode = {};

  static Future<CoronaSummary> fetchAlbum() async {
    final response =
        await http.get('https://www.trackcorona.live/api/countries');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var countriesData = CountryData.fromJson(json.decode(response.body));
      var summary = CoronaSummary();
      summary.countries = List<CountrySummary>();
      summary.global = GlobalSummary();
      summary.global.totalConfirmed = 0;
      summary.global.totalRecovered = 0;
      summary.global.totalDeaths = 0;
      countriesData.data.forEach((element) {
        summary.global.totalConfirmed += element.confirmed;
        summary.global.totalDeaths += element.dead;
        summary.global.totalRecovered += element.recovered;
        var country = CountrySummary();
        country.country = element.location;
        country.countryCode = element.countryCode;
        country.totalConfirmed = element.confirmed;
        country.totalRecovered = element.recovered;
        country.totalDeaths = element.dead;
        country.latlng = LatLng(element.latitude, element.longitude);
        summary.countries.add(country);
      });

      return summary;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load corona summary');
    }
  }

  static CountrySummary getSummaryFor(CoronaSummary data, String countryName) {
    if (countryName == 'Global') {
      var globalData = CountrySummary();
      globalData.totalConfirmed = data.global.totalConfirmed;
      globalData.totalDeaths = data.global.totalDeaths;
      globalData.totalRecovered = data.global.totalRecovered;

      return globalData;
    }
    setCountriesList(data);
    return data.countries
        .firstWhere((country) => country.country == countryName);
  }

  static void setCountriesList(CoronaSummary data) {
    data.countries.sort((a, b) => b.totalConfirmed.compareTo(a.totalConfirmed));
    data.countries.forEach(
        (country) => countryCode[country.country] = country.countryCode);
  }
}
