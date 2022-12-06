import 'package:flutter/material.dart';
import 'package:water_monitoring_2/article_screen/articleScreen.dart';
import 'package:water_monitoring_2/defaultAssets.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:water_monitoring_2/home_screen/homeScreen.dart';
import 'package:water_monitoring_2/profile/profileScreen.dart';

// Halaman tampilan utama, memperlihatkan tampilan utama list sungai-sungai

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DefaultAsset df = DefaultAsset();
  int selectedNavbar = 1;
  bool shadowColor = false;
  double? scrolledUnderElevation;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      ArticleScreen(),
      HomeScreen(),
      ProfileScreen(),
    ];
    print('${MediaQuery.of(context).size.width}');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Water Monitoring',
              style: TextStyle(color: Colors.white),
            ),
          ),
          scrolledUnderElevation: scrolledUnderElevation,
          shadowColor:
              shadowColor ? Theme.of(context).colorScheme.shadow : null,
        ),
        body: widgets[selectedNavbar],
        bottomNavigationBar: ConvexAppBar(
          items: [
            TabItem(icon: Icons.map, title: 'Discovery'),
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.people, title: 'Profile'),
          ],
          initialActiveIndex: 1,
          onTap: (int i) => {
            setState(
              () {
                selectedNavbar = i;
              },
            )
          },
          backgroundColor: Colors.lightBlue,
        ),
      ),
    );
  }
}
