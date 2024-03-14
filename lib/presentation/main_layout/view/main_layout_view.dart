import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:temp_house/presentation/main_layout/pages/favourait/view/favourite_page.dart';
import 'package:temp_house/presentation/main_layout/pages/home_screen/view/home_page.dart';
import 'package:temp_house/presentation/main_layout/pages/notifications_screen/view/NotificationPage.dart';
import 'package:temp_house/presentation/main_layout/pages/profile_screen/view/ProfilePage.dart';

class MainLayoutScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
      overlays: [SystemUiOverlay.bottom],
    );
    return Scaffold(


      bottomNavigationBar: BottomNavigationBar(
showUnselectedLabels: true,
        enableFeedback: true,
        onTap: (index){

          setState(() {
            selectedTabIndex = index;
          });
        },
        currentIndex: selectedTabIndex,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Icon(Icons.home),
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Icon(Icons.favorite_border),
              ),
              label: 'Favorite'),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Icon(Icons.notifications),
              ),
              label: 'Notifications'),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Icon(Icons.person),
              ),
              label: 'My profile'),

        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [

          Column(
            children: [

              Expanded(child: tabs[selectedTabIndex]),
            ],
          ),
        ],
      ),
    );

  }
  List<Widget> tabs = [
    HomePage(),
    FavouritePage(),
    NotificationPage(),
    ProfilePage()
  ];
}