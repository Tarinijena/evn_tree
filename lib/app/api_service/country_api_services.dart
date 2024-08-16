import 'dart:convert';
import 'package:http/http.dart' as http;

class CountryApiServices {

  static const String apiUrl = 'https://restcountries.com/v3.1/all';

  Future<List<String>> fetchCountries() async {
    
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<String> countries = data.map((country) {
        return country['name']['common'] as String;
      }).toList();
      return countries;
    } else {
      throw Exception('Failed to load countries');
    }
  }
}