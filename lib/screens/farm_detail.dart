import 'package:flutter/material.dart';
import 'package:e_shamber/utils/database_helper.dart';
import 'package:e_shamber/models/farm.dart';
import 'package:intl/intl.dart';
import 'dart:async';



class FarmDetail extends StatefulWidget{

  final String appBarTitle;
  final Farm farm;

  FarmDetail(this.farm, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FarmDetailState(this.farm, this.appBarTitle);
  }
}

class FarmDetailState extends State<FarmDetail>{

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Farm farm;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  FarmDetailState(this.farm, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = farm.title;
    descriptionController.text = farm.description;

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),

      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[

            //First element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: titleController,
                style: textStyle,
                onChanged: (value){
                  updateTitle();
                },
                decoration: InputDecoration(
                  labelText: 'Farm Name',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  )
                ),
              ),
            ),

            //Second element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: descriptionController,
                style: textStyle,
                onChanged: (value){
                  updateDescription();
                },
                decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),



            //Forth element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: (){
                        setState(() {
                          debugPrint('Save button clicked');
                        });
                      },
                    ),
                  ),

                  Container(width: 5.0,),

                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Delete',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: (){
                        setState(() {
                          debugPrint('Delete button clicked');
                        });
                      },
                    ),
                  )
                ],
              ),
            )


          ],
        ),
      ),
    );
  }

  void moveToLastScreen(){
    Navigator.pop(context, true);
  }

  // Update the title of Farm object
  void updateTitle(){
    farm.title = titleController.text;
  }

  // Update the description of Farm object
  void updateDescription() {
    farm.description = descriptionController.text;
  }


  // Save data to database
  void _save() async {

    moveToLastScreen();

    farm.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (farm.id != null) {  // Case 1: Update operation
      result = await helper.updateFarm(farm);
    } else { // Case 2: Insert Operation
      result = await helper.insertFarm(farm);
    }

    if (result != 0) {  // Success
      _showAlertDialog('Status', 'Farm Saved Successfully');
    } else {  // Failure
      _showAlertDialog('Status', 'Problem Saving Farm');
    }

  }


  void _delete() async {

    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW FARM i.e. he has come to
    // the detail page by pressing the FAB of FarmList page.
    if (farm.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteFarm(farm.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Farm Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Farm');
    }
  }

  void _showAlertDialog(String title, String message) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }


}