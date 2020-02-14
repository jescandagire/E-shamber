import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:e_shamber/utils/utils.dart';
import 'package:e_shamber/widgets/widgets.dart';
import 'package:e_shamber/screens/page_support_search.dart';

class SupportPage extends StatefulWidget {
  final String userName;
  final String userPassword;

  // receive data from the FirstScreen as a parameter
  SupportPage({Key key, @required this.userName,this.userPassword}): super(key: key);
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  Screen size;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 25.0,color: Colors.white);

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery
        .of(context)
        .size);

    String username = widget.userName;
    String userPassword = widget.userPassword;
    username = "John";

    return Scaffold(
      //appBar: AppBar(
      //backgroundColor: Colors.amber,
      //),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //SizedBox(height: 10),
            SizedBox(height: 150,child: upperPart(username)),
            SizedBox(height: 10,),
            SizedBox(height: 160,child: searchBoxCard()),
          ],
        ),
      ),
    );
  }

  Widget upperPart(String Username) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: UpperClipper(),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green[800],Colors.green[400]],
              ),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
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
    return Text("    How can we support you?",textAlign: TextAlign.center,
        style: style);
  }

  Card searchBoxCard() {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.symmetric(
          horizontal: size.getWidthPx(15), vertical: size.getWidthPx(2)),
      borderOnForeground: true,
      child: Container(
        height: 330,
        child: Column(
          children: <Widget>[
            _searchWidget(),
            SizedBox(height: 7),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text("View tips and instructons on the different farming methods, and proper farming practices. ",
                  style: TextStyle(fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }

  Card _searchWidget() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child:Container (
        decoration: new BoxDecoration (
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.green[400],Colors.green[600]],
          ),
          //color: Colors.amber
        ),
        child: new ListTile(
          leading: Text('Search here  ',style: TextStyle(fontSize: 20,color: Colors.white),),
          trailing: IconButton(
            iconSize: 30,
            color: Colors.white,
            icon: Icon(Icons.search),
            onPressed: (){
              //go to reports search page
              Navigator.of(context).push(_navigateToReportsSearchPageRoute());
              //navigateToReportsSearchPage();
            },
          ),
        ),
      ),
    );
  }

  Route _navigateToReportsSearchPageRoute(){
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SupportSearchPage(),
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
