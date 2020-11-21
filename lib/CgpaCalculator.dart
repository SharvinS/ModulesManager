import 'package:flutter/material.dart';
import 'database.dart';
import 'coursedb.dart';

class CgpaCalculatorRoute extends StatefulWidget {
  @override
  _CgpaCalculatorRoute createState() => new _CgpaCalculatorRoute();
}


class _CgpaCalculatorRoute extends State<CgpaCalculatorRoute> {
  int accNo = 0;
  String gpa;
  String chr;
  double gpat = 0;
  double chrt = 0;
  double cgpa = 0;
  String cgpaString;
  double gpan = 0;
  double chrn = 0;
  double gpar = 0;
  String gpanString;

  calculatecgpa() {
    gpan = double.parse(gpa);
    chrn = double.parse(chr);
    gpar = gpan * chrn;
    gpat += gpar;
    chrt += chrn;
    cgpa = gpat / chrt;

    cgpaString = (cgpa).toStringAsFixed(2);
    gpanString = (gpan).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            //create an empty whole page which is the main layout
            appBar: AppBar(
              //create an app bar for the page
              backgroundColor:
                  Colors.blue[800], //color of the app bar
              title: Text(
                "MODULES MANAGER" //text displayed on the app bar
              ),
              leading: new Container(),
              centerTitle: true,
            ),
            body: new Material(
              //the body of the homepage
              child: new Container(
                  //contains all the content of the page body
                  padding: new EdgeInsets.only(
                      top: 30.0,
                      left: 30.0,
                      right: 30.0), //the spacing between border and container
                  color: Colors.black26, //background color of the page
                  child: new Column(
                      //column to insert item
                      mainAxisAlignment:
                          MainAxisAlignment.center, //alignment of the column
                      children: [
                        //holds widgets for the previous widgets

                        new Container(
                          child: Text(
                            "Semester                 GPA                 CGPA",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),

                        new Container(
                            width: 300.0,
                            height: 450.0,
                            child: Material(
                              elevation: 8.0,
                              color: Colors.white70,
                              child: FutureBuilder<List<GPAdb>>(
                                  future: CoursedbDatabaseProvider.db
                                      .getAllGPAdbs(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<GPAdb>> snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            GPAdb item = snapshot.data[index];

                                            gpa = item.gpa;
                                            chr = item.chr;
                                            calculatecgpa();

                                            return Dismissible(
                                              key: UniqueKey(),
                                              background:
                                                  Container(color: Colors.red),
                                              onDismissed: (direction) {
                                                CoursedbDatabaseProvider.db
                                                    .deleteGPAdbWithSemester(item.semester);
                                                CoursedbDatabaseProvider.db
                                                    .deleteCoursedbWithSemester(item.semester);
                                                setState(() {});
                                              },
                                              child: Row(
                                                children: <Widget>[
                                                  new Container(
                                                    height: 50.0,
                                                    width: 100.0,
                                                    child: ListTile(
                                                      title: Text(item.semester,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16)),
                                                    ),
                                                  ),
                                                  new Container(
                                                    height: 50.0,
                                                    width: 100.0,
                                                    child: ListTile(
                                                      title: Text(gpanString,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16)),
                                                    ),
                                                  ),
                                                  new Container(
                                                    height: 50.0,
                                                    width: 100.0,
                                                    child: ListTile(
                                                      title: Text(cgpaString,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    } else {
                                      accNo = 0;
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }),
                            )),

                        //start of the back button
                        new Container(
                          //container to create a button
                          padding: EdgeInsets.only(
                              top: 20.0), //spacing above the back button
                          child: new Row(
                            //create row to allow alignment of button
                            mainAxisAlignment:
                                MainAxisAlignment.start, //alignment of the row
                            children: [
                              //holds widgets for the previous widgets
                              new Container(
                                //holds the back button
                                padding: new EdgeInsets.all(
                                    10.0), //distance between container and border
                                child: new Material(
                                  //allows creation and  customization of a widget
                                  borderRadius: new BorderRadius.circular(
                                      25.0), //curve edges of the widget
                                  elevation:
                                      10.0, //elevation value of the widget
                                  color: Colors.deepOrangeAccent[
                                      400], //color of the widget
                                  child: MaterialButton(
                                    //create a button within the material
                                    minWidth: 80.0, //width of the button
                                    height: 20.0, //height of the button
                                    padding: EdgeInsets.fromLTRB(
                                        20.0,
                                        15.0,
                                        20.0,
                                        15.0), // distance from text and border

                                    //action upon clicking the button which navigates to the homepage
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Back", //text displayed on the button
                                      textAlign: TextAlign
                                          .center, //alignment of the text
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ])),
            )));
  }
}
