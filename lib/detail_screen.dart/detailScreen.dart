import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:water_monitoring_2/detail_screen.dart/switch.dart';
import 'package:water_monitoring_2/profile/profileScreen.dart';
import 'package:water_monitoring_2/defaultAssets.dart';
import 'package:http/http.dart' as http;

var informationTextStyle = TextStyle(fontFamily: 'Oxygen');

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

Future<River> fetchRiver(int id) async {
  // final response = await http
  //     .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  final response =
      await http.get(Uri.parse('http://10.104.129.0:3000/data/$id'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return River.fromJson(jsonDecode(response.body));
    // return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class DetailScreen extends StatefulWidget {
  final int id;
  const DetailScreen({Key? key, required this.id}) : super(key: key);
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

// void fetchdata() async {
//   RiverApi.getCharacters().then((response) {
//     setState(() {
//       Iterable list = json.decode(response.body);
//       _riverList = list.map((model) => River.fromJson(model)).toList();
//     });
//   });
// }
class _DetailScreenState extends State<DetailScreen> {
  late Future<River> futureAlbum;
  DefaultAsset df = DefaultAsset();
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchRiver(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar()),
      body: Container(
        decoration: df.defaultBackground,
        // width: 600,
        child: Center(
          child: FutureBuilder(
            future: futureAlbum,
            builder: (context, AsyncSnapshot<River> snapshot) {
              if (snapshot.hasData) {
                return Card(
                  margin: EdgeInsets.all(13.0),
                  child: ListView(
                    children: [
                      Center(
                        child: Text(
                          '${snapshot.data!.nama}',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 53, 71, 87),
                            shadows: [
                              BoxShadow(
                                color: Color.fromARGB(108, 0, 0, 0),
                                offset: Offset(1, 2),
                                blurRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height:
                                    100 - snapshot.data!.kedalaman.toDouble(),
                                width: 80,
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: snapshot.data!.kedalaman.toDouble(),
                                width: 80,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 62, 176, 242),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 103,
                            width: 83,
                            child: Container(
                              child: Center(
                                child: Text(
                                  '${snapshot.data!.kedalaman} %',
                                  style: TextStyle(
                                    color: Color.fromARGB(175, 110, 96, 239),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(175, 110, 96, 239),
                                    width: 3),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        color: Color.fromARGB(175, 110, 96, 239),
                        margin:
                            EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.water_drop_outlined,
                                color: Color.fromARGB(255, 96, 226, 255),
                              ),
                              Text(
                                '  Kedalaman Air : ${snapshot.data!.kedalaman} %',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Color.fromARGB(175, 110, 96, 239),
                        margin:
                            EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.hot_tub_rounded,
                                color: Color.fromARGB(255, 255, 127, 127),
                              ),
                              Text(
                                '  Suhu Air : ${snapshot.data!.suhu} C',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Color.fromARGB(175, 110, 96, 239),
                        margin:
                            EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.api,
                                color: Color.fromARGB(255, 236, 252, 91),
                              ),
                              Text(
                                '  TDS : ${snapshot.data!.tds}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Color.fromARGB(175, 110, 96, 239),
                        margin:
                            EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.h_plus_mobiledata,
                                color: Color.fromARGB(255, 129, 248, 176),
                              ),
                              Text(
                                '  pH : ${snapshot.data!.ph}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Color.fromARGB(173, 95, 210, 195),
                        margin:
                            EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_city,
                                color: Color.fromARGB(255, 193, 129, 248),
                              ),
                              Text(
                                '  Lokasi : ${snapshot.data!.lokasi}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      switchiot(
                        switches: snapshot.data!.switches,
                      ),
                      Center(
                        child: Text('On / Off'),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
