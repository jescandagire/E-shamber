import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:e_shamber/utils/utils.dart';
import 'package:e_shamber/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  final String userName;
  final String userPassword;

  // receive data from the FirstScreen as a parameter
  ProfilePage({Key key, @required this.userName,this.userPassword}): super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 25.0,color: Colors.white);
  Screen size;

  @override
  Widget build(BuildContext context) {
    String userName = widget.userName;
    String userPassword = widget.userPassword;
    userName = "Jesca";
    size = Screen(MediaQuery
        .of(context)
        .size);

    return Scaffold(
      //appBar: AppBar(
        //backgroundColor: Colors.cyan,
      //),
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarColor: backgroundColor,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: backgroundColor),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: <Widget>[
              //SizedBox(height: 10),
              SizedBox(height: 150,child: upperPart(userName)),
              SizedBox(height: 10),
              SizedBox(height: 100,child: userProfileBoxCard(userName)),
              SizedBox(height: 15),
              SizedBox(height: 300,child:Padding(
                  padding: EdgeInsets.only(left: 7,right: 7),
                  child: accountSection(userName,userPassword)),),
            ],
          ),
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
    return Text("My Profile",textAlign: TextAlign.center,
      style: style,);
  }

  Container userProfileBoxCard(String userName) {
    return Container(
        height: 100,
      child: Padding(
        padding: EdgeInsets.only(left: 10,right: 10),
        child: Column(
          children: <Widget>[
          Container(
            height: 100,
            child: Card(
              color: Colors.green[400],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child:new ListTile(
                  leading: IconButton(
                    iconSize: 70,
                    color: Colors.white,
                    icon: Icon(Icons.account_circle),
                    onPressed: (){
                      //go to reports search page
                      //navigateToReportsSearchPage();
                    },
                  ),
                  subtitle: Text(' $userName ',style: TextStyle(fontSize: 20,color: Colors.white),)
              ),
            ),
          ),
          ],
        ),
      )
    );
  }

}


SettingSection accountSection(String userName,String userPassword) {
  return SettingSection(
    headerText: "Account".toUpperCase(),
    headerFontSize: 16.0,
    headerTextColor: Colors.black87,
    backgroundColor: Colors.white,
    disableDivider: false,
    children: <Widget>[
      Container(
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: TileRow(
              label: "Change Username",
              disabled: false,
              rowValue: "$userName",
              disableDivider: false,
              onTap: () {
                //change username
                //navigationToChangeUsername(userName,userPassword);
              },
            ),
          )
      ),

      Container(
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: TileRow(
              label: "Change Password",
              disableDivider: false,
              onTap: () {
                //change password
                //navigationToChangePassword(userName,userPassword);
              },
            ),
          )
      ),

      Container(
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: TileRow(
            label: "Add new user",
            disabled: false,
            disableDivider: true,
            onTap: () {
              //add new user
              // navigationToAddUser(exRateValue);
            },
          ),

        )

      ),
    ],
  );
}


