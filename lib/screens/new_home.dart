import 'package:flutter/material.dart';

import 'package:e_shamber/screens/page_dash.dart';
import 'package:e_shamber/screens/page_profile.dart';
import 'package:e_shamber/screens/page_support.dart';

class HomePage extends StatefulWidget {
  final String userName;
  final String userPassword;
  // receive data from the FirstScreen as a parameter
  HomePage({Key key, @required this.userName,this.userPassword}): super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  int currentTab = 1;
  PageController pageController;

  _changeCurrentTab(int tab) {
    //Changing tabs from BottomNavigationBar
    setState(() {
      currentTab = tab;
      pageController.jumpToPage(0);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    String userName = widget.userName;
    String userPassword = widget.userPassword;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: bodyView(currentTab,userName,userPassword),
        bottomNavigationBar: BottomNavyBar(changeCurrentTab: _changeCurrentTab,),
      ),
    );
  }

  bodyView(currentTab,String userName,String userPassword) {
    List<Widget> tabView = [];
    //Current Tabs in Home Screen...
    switch (currentTab) {
      case 0:
      //Dashboard Page
        tabView = [SupportPage(userName:userName,userPassword: userPassword)];
        break;
      case 1:
      //Search Page
        tabView = [DashPage(userName:userName,userPassword: userPassword)];
        break;
      case 2:
      //Profile Page
        tabView = [ProfilePage(userName:userName,userPassword: userPassword)];
        break;
    }
    return PageView(controller: pageController, children: tabView);
  }
}


class BottomNavyBar extends StatefulWidget {
  final ValueChanged<int> changeCurrentTab;

  @override
  BottomNavyBar({Key key, this.changeCurrentTab}) : super(key: key);
  BottomNavyBarState createState() => BottomNavyBarState();
}

class BottomNavyBarState extends State<BottomNavyBar> {
  int selectedIndex = 1;

  Color backgroundColor = Colors.white;

  List<NavigationItem> items = [
    NavigationItem(Icon(Icons.help_outline),Text("Support"),Colors.green[400]),//amber[600]),
    NavigationItem(Icon(Icons.home),Text("Home"),Colors.green[400]),//purpleAccent
    NavigationItem(Icon(Icons.person_outline),Text("Profile"),Colors.green[400])
  ];

  Widget _buildItem(NavigationItem item, bool isSelected){
    return AnimatedContainer(
      duration: Duration(milliseconds: 270),
      height: double.maxFinite,
      width: isSelected ? 125:50,
      padding: isSelected ? EdgeInsets.only(left: 16,right: 16) : null,
      decoration: isSelected ? BoxDecoration(
        color: item.color,
        borderRadius: BorderRadius.all(Radius.circular(50))
      ) : null,
      child: ListView(
        scrollDirection: Axis.horizontal,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconTheme(
              data: IconThemeData(
                size: 24,
                color: isSelected ? backgroundColor : Colors.green,
              ),
              child: item.icon,
            ),Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: isSelected ?
              DefaultTextStyle.merge(
                  style: TextStyle(
                      color: backgroundColor
                  ),
                  child: item.title)
                  : Container(),
            ),
          ],
        )
      ],
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: EdgeInsets.only(left: 8,top:4, bottom: 4,right: 8),
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
                color: Colors.green,
                blurRadius: 5
            )
          ]
      ),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item){
          var itemIndex = items.indexOf(item);
          return GestureDetector(
            onTap: (){
              setState(() {
                selectedIndex = itemIndex;
                widget.changeCurrentTab(selectedIndex);
              });
            },
            child: _buildItem(item, selectedIndex == itemIndex),
          );
        }).toList(),
      ),
    );
  }
}

class NavigationItem {
  final Icon icon;
  final Text title;
  final Color color;
  NavigationItem(this.icon,this.title,this.color);
}