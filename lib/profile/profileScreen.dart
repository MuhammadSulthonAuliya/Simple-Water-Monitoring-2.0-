import 'package:flutter/material.dart';
import 'package:water_monitoring_2/defaultAssets.dart';

class ProfileScreen extends StatelessWidget {
  DefaultAsset df = DefaultAsset();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Container(
        decoration: df.defaultBackground,
        child: SafeArea(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircleAvatar(
            radius: 50.0,
            backgroundImage: AssetImage('assets/images/1.jpg'),
          ),
          Text(
            'M Sulthon A',
            style: TextStyle(
              fontFamily: 'Pacifico',
              fontSize: 40.0,
              color: Colors.white,
            ),
          ),
          Text(
            'Calon Mubaligh',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Source Sans Pro',
              color: Color.fromARGB(255, 161, 223, 240),
              letterSpacing: 2.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
            width: 300,
            child: Divider(
              color: Colors.black,
            ),
          ),
          Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.contact_phone_sharp,
                  color: Colors.teal,
                ),
                title: Text(
                  '089629948693',
                  style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade900,
                  ),
                ),
              )),
          Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.contact_mail_sharp,
                color: Colors.teal,
              ),
              title: Text(
                'muhammadsulthonauliya@gmail.com',
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.teal.shade900,
                ),
              ),
            ),
          )
        ])),
      ),
    );
  }
}
