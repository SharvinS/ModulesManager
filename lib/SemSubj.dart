import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cgpa_calculator_assignment/InsertSemester.dart';

class GPA extends StatefulWidget {
  @override
  GPAState createState() => new GPAState();
}

class GPAState extends State<GPA> {
  TextEditingController subjectnumber = new TextEditingController();
  TextEditingController semnumber = new TextEditingController();
  int n;
  int sem;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
            title: new Text("MODULES MANAGER",
              style: TextStyle(color: Colors.black
              ),),
            leading: new Container(),
            centerTitle: true,
            backgroundColor: Colors.white70),
        body: new Material(
            child: new Container(
          color: Colors.black26,
          padding: EdgeInsets.all(30.0),
              child: new Column(
              //column to insert item
              mainAxisAlignment:
                  MainAxisAlignment.center, //alignment of the column
                  // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //holds widgets for the previous widgets
                new Container(
                  height: 450,
                  width: 300,
                  child: new ListView(
                    children: <Widget>[

                      new Container(
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text("Semester Details",
                            textAlign: TextAlign.center,
                            style: TextStyle (fontSize: 20),)
                          ],
                        )
                      ),
                      new Container(
                        height: 80.0,
                      ),
                      new Container(
                        height: 50.0,
                        child: TextField(
                          textAlign: TextAlign.center,
                          autofocus: true,
                          decoration: new InputDecoration(
                              hintText: "Insert semester",
                              border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide())),
                          keyboardType: TextInputType.number,
                          controller: semnumber,
                          onChanged: (String str) {
                            setState(() {
                              if (semnumber.text == "") sem = 0;
                              sem = int.parse(semnumber.text);
                            });
                          },
                        ),
                      ),
                      new Padding(padding: EdgeInsets.only(bottom: 15.0)),
                      new Container(
                        height: 67.0,
                        child: TextField(
                          textAlign: TextAlign.center,
                          autofocus: true,
                          decoration: new InputDecoration(
                              hintText: "Insert number of subjects",
                              border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide())),
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          controller: subjectnumber,
                          onChanged: (String str) {
                            setState(() {
                              if (subjectnumber.text == "") n = 0;
                              n = int.parse(subjectnumber.text);
                            });
                          },
                        ),
                      ),
                      new Padding(padding: EdgeInsets.only(bottom: 30.0)),
                      new Container(
                          padding: new EdgeInsets.all(10.0),
                          child: new Material(
                              elevation: 10.0,
                              borderRadius: new BorderRadius.circular(50.0),
                              color: Colors.white70,
                              child: MaterialButton(
                                  minWidth: 80.0,
                                  height: 20.0,
                                  padding: EdgeInsets.all(10.0),
                                  onPressed: () {
                                    if ((n is int && n > 0) &&
                                        (sem is int && sem > 0)) {
                                      int pass = n;
                                      int passem = sem;
                                      n = 0;
                                      sem = 0;
                                      subjectnumber.text = "";
                                      semnumber.text = "";
                                      Navigator.of(context).push(
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new GPAcalc(pass, passem)));
                                    } else {
                                      subjectnumber.text = "";
                                      alert();
                                    }
                                  },
                                  child: Text(
                                    'CONTINUE',
                                  )
                              )
                          )
                      )
                    ],
                  ),
                ),

                new Padding(padding: EdgeInsets.only(top: 100)),

                new Container(
                  //container to create a button
                  padding: EdgeInsets.only(
                      top: 10.0), //spacing above the back button
                  child: new Row(
                    //create row to allow alignment of button
                    mainAxisAlignment:
                        MainAxisAlignment.center, //alignment of the row
                    children: [
                      //holds widgets for the previous widgets
                      new Container(
                        //holds the back button
                        padding: new EdgeInsets.all(
                            10.0), //distance between container and border
                        child: new Material(
                          //allows creation and  customization of a widget
                          elevation: 10.0, //elevation value of the widget
                          color: Colors.white70, //color of the widget
                          child: MaterialButton(
                            //create a button within the material
                            minWidth: 80.0, //width of the button
                            height: 20.0, //height of the button
                            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0,
                                15.0), // distance from text and border

                            //action upon clicking the button which navigates to the homepage
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "BACK", //text displayed on the button
                              textAlign:
                                  TextAlign.center, //alignment of the text
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        )));
  }

  Future<Null> alert() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Error'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('Fill in all the text fields'),
              ],
            ),
          ),
          actions: <Widget>[
            new RaisedButton(
              elevation: 5.0,
              color: Colors.white70,
              child: new Text(
                "Go Back",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
