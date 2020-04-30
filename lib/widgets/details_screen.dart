import 'package:covid19_project/constant.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/my_header.dart';
import 'package:flutter/material.dart';

class Summary {
  final String country;
  final int newConfirmed;
  final int totalConfirmed;
  final int newDeaths;
  final int totalDeaths;
  final int newRecovered;
  final int totalRecovered;

  Summary({
    this.country,
    this.newConfirmed,
    this.totalConfirmed,
    this.newDeaths,
    this.totalDeaths,
    this.newRecovered,
    this.totalRecovered,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      country: json['Country'],
      newConfirmed: json['NewConfirmed'],
      totalConfirmed: json['TotalConfirmed'],
      newDeaths: json['NewDeaths'],
      totalDeaths: json['TotalDeaths'],
      newRecovered: json['NewRecovered'],
      totalRecovered: json['TotalRecovered'],
    );
  }
}

Future<List<Summary>> fetchSummary() async {
  final response = await http.get('https://api.covid19api.com/summary');

  if (response.statusCode == 200) {
    // var data =
        // '{ "Global": { "NewConfirmed": 100282, "TotalConfirmed": 1162857, "NewDeaths": 5658, "TotalDeaths": 63263, "NewRecovered": 15405, "TotalRecovered": 230845 }, "Countries": [ { "Country": "ALA Aland Islands", "CountryCode": "AX", "Slug": "ala-aland-islands", "NewConfirmed": 0, "TotalConfirmed": 0, "NewDeaths": 0, "TotalDeaths": 0, "NewRecovered": 0, "TotalRecovered": 0, "Date": "2020-04-05T06:37:00Z" },{ "Country": "Zimbabwe", "CountryCode": "ZW", "Slug": "zimbabwe", "NewConfirmed": 0, "TotalConfirmed": 9, "NewDeaths": 0, "TotalDeaths": 1, "NewRecovered": 0, "TotalRecovered": 0, "Date": "2020-04-05T06:37:00Z" } ], "Date": "2020-04-05T06:37:00Z" }';
    var parsed = json.decode(response.body);
    // print(parsed.length);
    List jsonResponse = parsed["Countries"] as List;

    return jsonResponse.map((job) => new Summary.fromJson(job)).toList();
  } else {
    print('Error, Could not load Data.');
    throw Exception('Failed to load Data');
  }
}

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final controller = ScrollController();
  double offset = 0;

  Future<List<Summary>> _func;

  @override
  void initState() {
    _func = fetchSummary();
    controller.addListener(onScroll);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Summary>>(
        future: _func,
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            List<Summary> data = snapshot.data;
            // print(data);
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MyHeader(
                    image: "assets/icons/world.svg",
                    textTop: "",
                    textBottom: "",
                    iconleft: true,
                    offset: offset,
                  ),
                  Center(
                    child: Text('Worldwide Cases ->', style: dHeadingTextStyle,),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:10.0
                    ),
                    child: Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          sortColumnIndex: 1,
                          sortAscending: true,
                          columns: [
                            DataColumn(
                              label: Text(
                                'Country',
                                style: TextStyle(
                                  color: dPrimaryColor,
                                  fontSize: 18.0,
                                ),
                              ),
                              numeric: false,
                              tooltip: "Country Name",
                            ),
                            DataColumn(
                              label: Text(
                                'Total Confirmed',
                                style: TextStyle(
                                  color: Colors.orange.shade900,
                                  fontSize: 16.0,
                                ),
                              ),
                              numeric: true,
                              tooltip: "Total Confirmed",
                            ),
                            DataColumn(
                              label: Text(
                                'New Confirmed',
                                style: TextStyle(
                                  color: dInfectedColor,
                                  fontSize: 16.0,
                                ),
                              ),
                              numeric: true,
                              tooltip: "New Confirmed",
                            ),
                            DataColumn(
                              label: Text(
                                'Total Deaths',
                                style: TextStyle(
                                  color: Colors.red.shade700,
                                  fontSize: 16.0,
                                ),
                              ),
                              numeric: true,
                              tooltip: "Total Deaths",
                            ),
                            DataColumn(
                              label: Text(
                                'New Deaths',
                                style: TextStyle(
                                  color: dDeathColor,
                                  fontSize: 16.0,
                                ),
                              ),
                              numeric: true,
                              tooltip: "New Deaths",
                            ),
                            DataColumn(
                              label: Text(
                                'Total Recovered',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16.0,
                                ),
                              ),
                              numeric: true,
                              tooltip: "Total Recovered",
                            ),
                            DataColumn(
                              label: Text(
                                'New Recovered',
                                style: TextStyle(
                                  color: dRecovercolor,
                                  fontSize: 16.0,
                                ),
                              ),
                              numeric: true,
                              tooltip: "New Recovered",
                            ),
                          ],
                          rows: data
                              .map(
                                (country) => DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        country.country,
                                        softWrap: true,
                                        style: TextStyle(fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          country.totalConfirmed.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          country.newConfirmed.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          country.totalDeaths.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          country.newDeaths.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          country.totalRecovered.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          country.newRecovered.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 500),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return AlertDialog(
              title: Text(
                'An Error Occured!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              content: Text(
                "${snapshot.error}",
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Go Back',
                    style: TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
          // By default, show a loading spinner.
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('This may take some time..')
              ],
            ),
          );
        },
      ),
    );
  }
}
