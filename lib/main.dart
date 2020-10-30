import 'package:flutter/material.dart';
import 'package:cgpa_calculator_assignment/SemSubj.dart';
import 'CgpaCalculator.dart';
import 'Course.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: new HomeScreen());
  }
}

//User landing class
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold( //create an empty whole page which is the main layout
      appBar: AppBar(     //create an app bar for the homepage
          backgroundColor: Colors.blue[800],    //color of the app bar
          title: Text('CGPA CALCULATOR')    //text displayed on the app bar
      ),
      body: new Material(   //the body of the homepage
        child: new Container( //contains all the content of the page body
          padding: const EdgeInsets.all(30.0),    //the spacing between border and container
          color: Colors.grey[900],    //background color of the homepage
          child: new Center(    //the position of the container set to center
            child: new Column(children: [   //a column to insert item
              new Padding(padding: EdgeInsets.only(top: 20.0)),   //the distance between the app bar and column
              new Text(   //insertion of text in the column
                'WELCOME',
                style: new TextStyle(   //styling of the text
                    color: Colors.white,    //color of the text
                    fontSize: 25.0    //size of the text
                ),
              ),
              new Padding(padding: EdgeInsets.only(top: 30.0)),   //spacing above the image
              new Container(  //Container to insert an image.
                child: Image.asset('assets/result.png', width: 120.0, height: 120.0,    //insertion of image file
                ),
              ),
              new Padding(padding: EdgeInsets.only(bottom: 50.0)), //spacing below the image

              //start of first button
              new Container(
                padding: new EdgeInsets.all(10.0),    //the spacing between border and container
                child: new Material(    //allows creation and  customization of a widget
                    elevation: 10.0,    //elevation value of the widget
                    borderRadius: new BorderRadius.circular(25.0),    //curve edges of the widget
                    color: Colors.blue[800],    //color of the widget
                    child: MaterialButton(    //create a button within the material
                        minWidth: 50.0,
                        height: 50.0,//width of the button
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),   // distance from text and border

                        //action upon clicking the button which navigates to the assigned page
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => GPA()  //the destination page to navigate too
                            ),
                          );
                        },
                        child:  Text('        GPA\nCALCULATOR',)   //text displayed on the button
                    )
                ),
              ),

              //start of second button, please refer to first button
              new Container(
                padding: new EdgeInsets.all(10.0),
                child: new Material(
                    elevation: 10.0,
                    borderRadius: new BorderRadius.circular(25.0),
                    color: Colors.blue[800],
                    child: MaterialButton(
                        minWidth: 50.0,
                        height: 50.0,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => CgpaCalculatorRoute()),
                          );
                        },
                        child:  Text('        CGPA\nCALCULATOR',
                        )
                    )
                ),
              ),

              //start of third button, please refer to first button
              new Container(
                padding: new EdgeInsets.all(10.0),
                child: new Material(
                    elevation: 10.0,
                    borderRadius: new BorderRadius.circular(25.0),
                    color: Colors.blue[800],
                    child: MaterialButton(
                        minWidth: 117.0,
                        height: 50.0,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => CourseRoute()),
                          );
                        },
                        child:  Text('COURSE\n    LIST',)
                    )
                ),
              ),
            ]),
          ),
        ),
      ),

    );
  }
}
