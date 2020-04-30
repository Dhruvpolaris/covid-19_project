// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class Summary {
//   final String country;
//   final int newConfirmed;
//   final int totalConfirmed;
//   final int newDeaths;
//   final int totalDeaths;
//   final int newRecovered;
//   final int totalRecovered;

//   Summary({
//     this.country,
//     this.newConfirmed,
//     this.totalConfirmed,
//     this.newDeaths,
//     this.totalDeaths,
//     this.newRecovered,
//     this.totalRecovered,
//   });

//   factory Summary.fromJson(Map<String, dynamic> json) {
//     return Summary(
//       country: json['Country'],
//       newConfirmed: json['NewConfirmed'],
//       totalConfirmed: json['TotalConfirmed'],
//       newDeaths: json['NewDeaths'],
//       totalDeaths: json['TotalDeaths'],
//       newRecovered: json['NewRecovered'],
//       totalRecovered: json['TotalRecovered'],
//     );
//   }
// }

// Future<List<Summary>> fetchSummary() async {
//   final response = await http.get('https://api.covid19api.com/summary');

//   if (response.statusCode == 200) {
//     var parsed = json.decode(response.body);
//     print(parsed.length);
//     List jsonResponse = parsed["Countries"] as List;

//     return jsonResponse.map((job) => new Summary.fromJson(job)).toList();
//   } else {
//     print('Error, Could not load Data.');
//     throw Exception('Failed to load Data');
//   }
// }
