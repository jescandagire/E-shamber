import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:e_shamber/utils/utils.dart';
import 'package:e_shamber/widgets/widgets.dart';
import 'package:nice_button/nice_button.dart';

import 'package:flutter/cupertino.dart';

class InvestorGroupsPage extends StatefulWidget {
  @override
  _InvestorGroupsPageState createState() => _InvestorGroupsPageState();
}

class _InvestorGroupsPageState extends State<InvestorGroupsPage> {
  Screen size;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextStyle style1 = TextStyle(fontFamily: 'Montserrat', fontSize: 13.0);

  TextStyle style2 = TextStyle(fontFamily: 'Montserrat', fontSize: 17.0);
  TextStyle style3 = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);


  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery
        .of(context)
        .size);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Center(child: Text("Investor Groups"),),
      ),
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
            ],
          ),
        ),
      ),
    );
  }

}




