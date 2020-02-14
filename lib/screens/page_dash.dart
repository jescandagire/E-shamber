import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:e_shamber/widgets/widgets.dart';
import 'package:e_shamber/utils/utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:e_shamber/screens/page_my_farm.dart';
import 'package:e_shamber/screens/page_add_farm.dart';
import 'package:e_shamber/screens/page_investor_groups.dart';
import 'package:e_shamber/screens/farm_detail.dart';

// Sets a platform override for desktop to avoid exceptions. See
void enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

class DashPage extends StatefulWidget {
  final String userName;
  final String userPassword;

  TextEditingController userSearchController = TextEditingController();

  // receive data from the FirstScreen as a parameter
  DashPage({Key key, @required this.userName,this.userPassword}): super(key: key);
  @override
  _DashPageState createState() => _DashPageState();
}

class _DashPageState extends State<DashPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 30.0,color: Colors.white);
  TextStyle style1 = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0,color: Colors.black);
  TextStyle style2 = TextStyle(fontFamily: 'Montserrat', fontSize: 10.0,color: Colors.black45);

  TextStyle style3 = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0,color: Colors.black);
  TextStyle style4 = TextStyle(fontFamily: 'Montserrat', fontSize: 14.0,color: Colors.black45);

  Screen size;


  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery
        .of(context)
        .size);

    String username = widget.userName;
    username = "Jesca";
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          //backgroundColor: Colors.black87,
          //appBar: AppBar(
            //backgroundColor: Colors.purpleAccent,
          //),
          body:
              StaggeredGridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 2.0,
                  children: <Widget>[
                    Container(height: 200,
                      child: upperPart(username),),
                    Container(
                      padding: EdgeInsets.only(left: 22.0,right: 10),
                      child: _buildTile1(
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column
                          (
                            //mainAxisAlignment: MainAxisAlignment.start,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>
                            [
                              Material(
                              child:
                              Container(
                                height: 130,
                                child: SizedBox(height: 40,child: IconButton(
                                  icon: Icon(Icons.streetview,color: Colors.green[400],),
                                  iconSize: 80,
                                ),),
                              ),),

                              Material(
                                child: Divider(
                                  thickness: 4,
                                  color: Colors.green[400],

                                ),),
                              Text('My Farm', style: style1,),
                              Text('View and edit farm records', style: style2),
                            ]
                        ),
                      ),
                      ),),

                    Container(
                      padding: EdgeInsets.only(left: 10.0,right: 22.0),
                      child: _buildTile2(
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column
                            (
                            //mainAxisAlignment: MainAxisAlignment.start,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>
                              [
                                Material(
                                  child:
                                  Container(
                                    height: 130,
                                    child: SizedBox(height: 40,child: IconButton(
                                      icon: Icon(Icons.collections_bookmark,color: Colors.brown[400],),
                                      iconSize: 80,
                                    ),),
                                  ),),

                                Material(
                                  child: Divider(
                                    thickness: 4,
                                    color: Colors.green[400],

                                  ),),
                                Text('Add Farm', style: style1,),
                                Text('View and edit farm records', style: style2),
                              ]
                          ),
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 26.0,right: 26.0,top: 20),
                      child: _buildTile3(
                        Padding
                          (
                          padding: const EdgeInsets.all(8.0),
                          child: Column
                            (
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>
                              [
                                Text('Investor Groups: ',
                                    style: style3,
                                    //maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),

                                ListTile(
                                  leading: IconButton(
                                    icon: Icon(Icons.group,color: Colors.green[400],),
                                    iconSize: 75,
                                  ),
                                  subtitle: Text("Join investor groups chats and get upto date information about farms performances, and tips",style: style4,),
                                ),
                              ]
                          ),
                        ),
                      ),),
                  ],

                  staggeredTiles: [
                    StaggeredTile.extent(2, 200.0),
                    StaggeredTile.extent(1, 200.0),
                    StaggeredTile.extent(1, 200.0),
                    StaggeredTile.extent(2, 160.0),


                  ],
                ),
              )
    );
  }


  Widget upperPart(String Username) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: UpperClipper(),
          child: Container(
            height: 300,
            width: size.getWidthPx(400),
            child: Image.asset("./images/soil.jpg", fit: BoxFit.fill,
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 25),
                  Center(child: titleWidget(Username),)
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Text titleWidget(String Username) {
    return Text("Welcome back to \n E-Shamber",textAlign: TextAlign.center,
        style: style,);
  }

  Widget _buildTile1(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell
          (
          // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null ? () => onTap() : () {Navigator.of(context).push(_navigateToMyFarmPageRoute());},
            child: child
        )
    );
  }

  Widget _buildTile2(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell
          (
          // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null ? () => onTap() : () {Navigator.of(context).push(_navigateToAddFarmPageRoute());},
            child: child
        )
    );
  }

  Widget _buildTile3(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell
          (
          // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null ? () => onTap() : () {Navigator.of(context).push(_navigateToInvestorGroupsPageRoute());},
            child: child
        )
    );
  }

  Route _navigateToMyFarmPageRoute(){
    return PageRouteBuilder(
//      pageBuilder: (context, animation, secondaryAnimation) => MyFarmPage(),
      pageBuilder: (context, animation, secondaryAnimation) => FarmList(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _navigateToAddFarmPageRoute(){
    return PageRouteBuilder(
//      pageBuilder: (context, animation, secondaryAnimation) => AddFarmPage(),
      pageBuilder: (context, animation, secondaryAnimation) => FarmDetail(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _navigateToInvestorGroupsPageRoute(){
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => InvestorGroupsPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }


}

