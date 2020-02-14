import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:e_shamber/utils/utils.dart';
import 'package:e_shamber/widgets/widgets.dart';
import 'package:nice_button/nice_button.dart';
import 'package:e_shamber/screens/page_edit_farm.dart';

import 'package:flutter/cupertino.dart';
//******new******
import 'dart:async';
import 'package:e_shamber/models/farm.dart';
import 'package:e_shamber/utils/database_helper.dart';
import 'package:e_shamber/screens/farm_detail.dart';
import 'package:sqflite/sqflite.dart';


//class MyFarmPage extends StatefulWidget {
//  @override
//  _MyFarmPageState createState() => _MyFarmPageState();
//}

//class _MyFarmPageState extends State<MyFarmPage> {
  Screen size;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextStyle style1 = TextStyle(fontFamily: 'Montserrat', fontSize: 10.0);

  TextStyle style2 = TextStyle(fontFamily: 'Montserrat', fontSize: 17.0);
  TextStyle style3 = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);

  List<List> farmList = [];

//  List<List> farmList = [["Kubuli Farm groups","cabbage"],["Mengo Chicken ltd","chicks"],["Bwaise Yam group","greens"],
//  ["Tuula LTD","soil"],["Kubuli Farm groups","chicks"],["Accra Fish farm ","cabbage"],["Kawempe Farm groups","chicks"],
//    ["Kazo poultry farm","cabbage"],["Matuuga Fish farm ","greens"],];

//  @override
//  Widget build(BuildContext context) {
//    size = Screen(MediaQuery
//        .of(context)
//        .size);
//
//    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.green[400],
//        leading: Builder(
//            builder: (BuildContext context){
//              return IconButton(
//                icon: Icon(Icons.arrow_back_ios),
//                onPressed: () {
//                  Navigator.pop(context,true);
//                },
//              );
//            }),
//        title: Text(" My Farms"),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.search),
//            onPressed: () {
//            },
//          ),
//          IconButton(
//            icon: Icon(Icons.notifications_active),
//            onPressed: () {
//            },
//          ),
//          SizedBox(height: 20,),
//        ],
//      ),
//      body: Container(
//          padding: EdgeInsets.all(10),
//          width: 400,
//          //height: 900,
//          child: _displayFarms(),
//      ),
//    );
//  }
//
//  //trailing button
//  Widget _deleteButton(String farmName,String Description, String imageName){
//    return Material(
//        elevation: 8.0,
//        color: Colors.green[400],
//        borderRadius: BorderRadius.circular(30.0),
//        child:MaterialButton(
//          minWidth: 30,
//          height: 20,
//          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//          onPressed: () {
//            //navigationToResults();
//            Navigator.of(context).push(_navigateToEditFarmPageRoute(farmName,Description,imageName));
//          },
//          child: Text("Delete",
//              textAlign: TextAlign.center,
//              style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.0,color: Colors.white)),
//        )
//    );
//  }
//
//  Widget _displayFarms() {
//    return new ListView.builder(
//        itemCount: farmList.length,
//        itemBuilder: (BuildContext context, int index) {
//          return new Card(
//            elevation: 5.0,
//            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//            child: ListTile(
//              leading: CircleAvatar(
//                backgroundImage: AssetImage("images/${farmList[index][1]}.jpg"), // no matter how big it is, it won't overflow
//              ),
//              subtitle: Text('${farmList[index][0]}',style: style1,),
//              trailing: _deleteButton(farmList[index][0], "We grow all sorts of poultry",farmList[index][1]),
//              onTap: (){
//
//              },
//            ),
//          );
//        }
//    );
//  }
//
//  Route _navigateToEditFarmPageRoute(String FarmName,String FarmDescription, String ImageName){
//    return PageRouteBuilder(
//      pageBuilder: (context, animation, secondaryAnimation) => EditFarmPage(farmName: FarmName,farmDescription: FarmDescription,imageName: ImageName,),
//      transitionsBuilder: (context, animation, secondaryAnimation, child) {
//        var begin = Offset(0.0, 1.0);
//        var end = Offset.zero;
//        var curve = Curves.ease;
//        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//        return SlideTransition(
//          position: animation.drive(tween),
//          child: child,
//        );
//      },
//    );
//  }
//
//}

//*********************************************************************NEW************************************************//

class FarmList extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FarmListState();
  }
}

class FarmListState extends State<FarmList>{

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Farm> farmList;
  int count = 0;

  @override
  Widget build(BuildContext context) {

    if (farmList == null) {
      farmList = List<Farm>();
      updateListView();
    }
    return Scaffold(

      appBar: AppBar(
        title: Text('Farms'),
      ),
      body: getFarmListView(),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          debugPrint('FAB Clicked');
          navigateToDetail(Farm('', '',''),'Add Farm');
        },

        tooltip: 'Add Farm',

        child: Icon(Icons.add),
      ),
    );
  }

  ListView getFarmListView(){

    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder:( BuildContext context, int position){
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
            ),
            title: Text(this.farmList[position].title, style: titleStyle,),

            subtitle: Text(this.farmList[position].date),

            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey,),
              onTap: (){
                _delete(context, farmList[position]);
              },
            ),


            onTap: (){
              debugPrint('ListTile Tapped');
              navigateToDetail(this.farmList[position],'Edit Farm');
            },
          ),
        );
      },
    );// ListView.builder
  }

  void _delete(BuildContext context, Farm farm) async {

    int result = await databaseHelper.deleteFarm(farm.id);
    if (result != 0){
      _showSnackBar(context, 'Farm Deleted Successfully');
      updateListView();
    }
  }
  void _showSnackBar(BuildContext context, String message){

    final snackBar = SnackBar( content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Farm farm, String title) async{
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context){
      return FarmDetail(farm, title);
    }));

    if (result == true){
      updateListView();
    }

  }

  void updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Farm>> farmListFuture = databaseHelper.getFarmList();
      farmListFuture.then((farmList) {
        setState(() {
          this.farmList = farmList;
          this.count = farmList.length;
        });
      });
    });
  }

}

