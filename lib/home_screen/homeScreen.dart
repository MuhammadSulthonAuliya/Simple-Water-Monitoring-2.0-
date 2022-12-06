import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:water_monitoring_2/defaultAssets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:water_monitoring_2/detail_screen.dart/detailScreen.dart';

class River {
  final int id;
  final String nama;
  final String lokasi;
  final num kedalaman;
  final bool switches;
  final num suhu;
  final num tds;
  final num ph;
  final String imageAsset;

  const River({
    required this.id,
    required this.nama,
    required this.lokasi,
    required this.kedalaman,
    required this.switches,
    required this.suhu,
    required this.tds,
    required this.ph,
    required this.imageAsset,
  });
  factory River.fromJson(Map<String, dynamic> json) {
    return River(
      id: json['id'],
      nama: json['nama'],
      lokasi: json['lokasi'],
      kedalaman: json['kedalaman'],
      switches: json['switches'],
      suhu: json['suhu'],
      tds: json['tds'],
      ph: json['ph'],
      imageAsset: json['imageAsset'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'lokasi': lokasi,
        'kedalaman': kedalaman,
        'switches': switches,
        'suhu': suhu,
        'tds': tds,
        'ph': ph,
        'imageAsset': imageAsset,
      };
}

// Fungsi fetchAPI
Future<List<River>> fetchRiver() async {
  // final response = await http
  //     .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  final response = await http.get(Uri.parse('http://10.104.129.0:3000/data'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    var jsonResponse = json.decode(response.body) as List;
    return jsonResponse.map((show) => River.fromJson(show)).toList();
    // return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DefaultAsset df = DefaultAsset();
  late Future<List<River>> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchRiver();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: futureAlbum,
            builder: (context, AsyncSnapshot<List<River>> snapshot) {
              if (snapshot.hasData) {
                return Center(
                    child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DetailScreen(id: index + 1);
                          }));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Image.network(
                                  snapshot.data![index].imageAsset),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      snapshot.data![index].nama,
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        'Kedalaman: ${snapshot.data![index].kedalaman} %'),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ));
                //         ListTile(
                //           contentPadding: const EdgeInsets.symmetric(
                //               horizontal: 30.0, vertical: 30.0),
                //           leading: CircleAvatar(
                //             radius: 20,
                //             backgroundImage:
                //                 NetworkImage(snapshot.data![index].imageAsset),
                //           ),
                //           title: Text(snapshot.data![index].nama),
                //           subtitle: Text(
                //               'Kedalaman: ${snapshot.data![index].kedalaman} %'),
                //           onTap: () {
                //             Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => DetailScreen()
                //                   // DetailScreen(
                //                   //     item: snapshot.data![index].id,
                //                   //     title: snapshot.data![index].nama),
                //                   ),
                //             );
                //           },
                //         ),
                //       );
                //     },
                //   ),
                // );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),

        // ListView.builder(
        //   itemBuilder: (context, index) {
        //     final TourismPlace place = tourismPlaceList[index];
        //     return InkWell(
        //       onTap: () {
        //         Navigator.push(context, MaterialPageRoute(builder: (context) {
        //           return DetailScreen();
        //         }));
        //       },
        //       child: Card(
        //         margin: EdgeInsets.all(10),
        //         child: Row(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: <Widget>[
        //             Expanded(
        //               flex: 1,
        //               child: Image.asset(place.imageAsset),
        //             ),
        //             Expanded(
        //               flex: 2,
        //               child: Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: <Widget>[
        //                     Text(
        //                       place.name,
        //                       style: TextStyle(fontSize: 16.0),
        //                     ),
        //                     SizedBox(
        //                       height: 10,
        //                     ),
        //                     Text(place.location),
        //                   ],
        //                 ),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        //   itemCount: tourismPlaceList.length,
        // ),

        // Center(
        //   child: Column(
        //     children: [
        //       CircularPercentIndicator(
        //         radius: 120.0,
        //         lineWidth: 13.0,
        //         animation: true,
        //         percent: 0.7,
        //         center: Text(
        //           "70.0%",
        //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        //         ),
        //         footer: new Text(
        //           "Water Level",
        //           style: new TextStyle(
        //               fontWeight: FontWeight.bold, fontSize: 17.0),
        //         ),
        //         circularStrokeCap: CircularStrokeCap.round,
        //         progressColor: Colors.orangeAccent,
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
