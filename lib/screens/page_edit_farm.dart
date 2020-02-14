import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:e_shamber/utils/utils.dart';
import 'package:e_shamber/widgets/widgets.dart';
import 'package:nice_button/nice_button.dart';


import 'package:flutter/cupertino.dart';

class EditFarmPage extends StatefulWidget {
  final String farmName;
  final String farmDescription;
  final String imageName;

  EditFarmPage({Key key, @required this.farmName,this.farmDescription, this.imageName}): super(key: key);
  @override
  _EditFarmPageState createState() => _EditFarmPageState();
}

class _EditFarmPageState extends State<EditFarmPage> {
  Screen size;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontStyle: FontStyle.italic,fontSize: 18.0,color: Colors.green[400]);
  TextStyle style1 = TextStyle(fontFamily: 'Montserrat', fontSize: 12.0,color: Colors.black,);

  TextStyle style2 = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0,fontStyle: FontStyle.italic);
  TextStyle style3 = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);


  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery
        .of(context)
        .size);
    String farmName = widget.farmName;
    String farmDescription = widget.farmDescription;
    String imageName = widget.imageName;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        leading: Builder(
            builder: (BuildContext context){
              return IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context,true);
                },
              );
            }),
        title: Text("Edit Farm",textAlign: TextAlign.center,),
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
              SizedBox(height: 10),
              SizedBox(height: 100,
                  child:Card(
                    elevation: 5.0,
                      child: Container(
                        padding: EdgeInsets.only(left: 50,right: 50,),
                        child: Row(
                          children: <Widget>[
                            Column(children: <Widget>[
                              SizedBox(height:40,),
                              Text("$farmName",style: style,),
                              Text("Growth Period: Jan - March",style: style1,),
                            ],),

                            SizedBox(width:10,),
                            Container(height: 80,
                              padding: EdgeInsets.only(top: 20),
                              width: 60,
                              child: CircleAvatar(
                                backgroundImage: AssetImage("images/$imageName.jpg"), // no matter how big it is, it won't overflow
                              ),
                            )
                          ],

                        )
                      ),
                  ),
              ),
              SizedBox(height: 10,),
              SizedBox(height: 100,child:
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10,),
                      Text("Farm Description: ",style: style2,),
                      SizedBox(height: 10,),
                      Divider(thickness: 2,
                      color: Colors.green[400],),
                    ],
                  ),
                ),),
              SizedBox(height: 50,),
              NiceButton(
                radius: 40,
                elevation: 10.0,
                padding: const EdgeInsets.only(left: 25,right: 25,top: 15,bottom: 15),
                text: " Save",
                icon: Icons.search,
                gradientColors: [Colors.green[400],Colors.green[600]],
                onPressed: () {
                  //submit inputs
                  //formKey.currentState.validate();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}




