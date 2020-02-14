import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:e_shamber/utils/utils.dart';
import 'package:e_shamber/widgets/widgets.dart';

class SupportSearchPage extends StatefulWidget {
  final String userName;
  final String userPassword;

  // receive data from the FirstScreen as a parameter
  SupportSearchPage({Key key, @required this.userName,this.userPassword}): super(key: key);
  @override
  _SupportSearchPageState createState() => _SupportSearchPageState();
}

class _SupportSearchPageState extends State<SupportSearchPage> {
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
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Text("Search anything"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

}
