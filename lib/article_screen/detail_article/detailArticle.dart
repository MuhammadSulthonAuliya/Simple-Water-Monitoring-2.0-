import 'package:flutter/material.dart';
import 'package:water_monitoring_2/article_screen/source_article.dart';
import 'package:water_monitoring_2/defaultAssets.dart';

class DetailArticle extends StatelessWidget {
  final SourceArticle id;
  DetailArticle({required this.id});

  DefaultAsset df = DefaultAsset();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar()),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: df.defaultBackground,
        // width: 600,
        child: Center(
          child: Card(
            child: ListView(children: [
              Center(
                  child: Text(
                id.title,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )),
              Center(child: Text(id.subtitle, style: TextStyle(fontSize: 13))),
              Center(
                  child: Padding(
                padding: EdgeInsets.all(10),
                child: Image.asset(id.imageAsset),
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(id.paragraph),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
