import 'package:flutter/material.dart';
import 'coursedb.dart';
import 'database.dart';



class CourseRoute extends StatefulWidget {
  @override
  _CourseRoute createState() => _CourseRoute();
}

class _CourseRoute extends State<CourseRoute> {

  int accNo = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(   //create an empty whole page which is the main layout
            appBar: AppBar(   //create an app bar for the page
              backgroundColor: Colors.white70,    //color of the app bar
                title: Text("MODULES MANAGER",
                  style: TextStyle(color: Colors.black
                  ),), //text displayed on the app bar
              leading: new Container(),
              centerTitle: true,
            ),
            body: new Material(   //the body of the homepage
              child: new Container(   //contains all the content of the page body
                  padding: new EdgeInsets.only(top: 30.0, left: 28.0, right: 28.0),   //the spacing between border and container
                  color: Colors.black26,   //background color of the page
                  child: new Column(    //column to insert item
                      mainAxisAlignment: MainAxisAlignment.center,    //alignment of the column
                      children:[    //holds widgets for the previous widgets
                        
                        new Container(
                          child: Text("SEMESTER            CODE              CREDIT        GRADE",
                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                        ),

                        new Padding(padding: EdgeInsets.only(bottom: 30.0)),

                        new Container(
                            width: 500.0,
                            height: 520.0,
                            child: Material(
                              color: Colors.white70,
                              child: FutureBuilder<List<Coursedb>>(
                                  future: CoursedbDatabaseProvider.db.getAllCoursedbs(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<Coursedb>> snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            Coursedb item = snapshot.data[index];
                                            return Dismissible(
                                              key: UniqueKey(),
                                               background: Container(color: Colors.red),
                                              onDismissed: (direction) {
                                                CoursedbDatabaseProvider.db
                                                    .deleteGPAdbWithSemester(item.semester);
                                                CoursedbDatabaseProvider.db
                                                    .deleteCoursedbWithSemester(item.semester);
                                                setState(() {});
                                              },
                                              child: Row(
                                                children: <Widget>[

                                                  new Padding(padding: EdgeInsets.only(left: 10.0)),

                                                  new Container(
                                                    height:50.0,
                                                    width: 70.0,
                                                    child: ListTile(
                                                      title: Text(item.semester,
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16)),
                                                    ),
                                                  ),

                                                  new Padding(padding: EdgeInsets.only(left: 0.0)),

                                                  new Container(
                                                    height:50.0,
                                                    width: 150.0,
                                                    child: ListTile(
                                                      title: Text(item.code,
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16)),
                                                    ),
                                                  ),

                                                  new Padding(padding: EdgeInsets.only(left: 0.0)),

                                                  new Container(
                                                    height:50.0,
                                                    width: 52.0,
                                                    child: ListTile(
                                                      title: Text(item.credit,
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16)),
                                                    ),
                                                  ),

                                                  new Padding(padding: EdgeInsets.only(left: 35.0)),

                                                  new Container(
                                                    height:50.0,
                                                    width: 52.0,
                                                    child: ListTile(
                                                      title: Text(item.grade,
                                                          textAlign: TextAlign.center,
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
                                      return Center(child: CircularProgressIndicator());
                                    }
                                  }),
                            )
                        ),

                        //start of the back button
                        new Container(    //container to create a button
                          padding: EdgeInsets.only(top: 20.0),    //spacing above the back button
                          child: new Row(   //create row to allow alignment of button
                            mainAxisAlignment: MainAxisAlignment.center,   //alignment of the row
                            children:[    //holds widgets for the previous widgets
                              new Container(    //holds the back button
                                padding: new EdgeInsets.all(10.0),    //distance between container and border
                                child: new Material(    //allows creation and  customization of a widget
                                  elevation: 10.0,    //elevation value of the widget
                                  color: Colors.white70,    //color of the widget
                                  child: MaterialButton(    //create a button within the material
                                    minWidth: 80.0,   //width of the button
                                    height: 20.0,   //height of the button
                                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),   // distance from text and border

                                    //action upon clicking the button which navigates to the homepage
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    child: Text("BACK",   //text displayed on the button
                                      textAlign: TextAlign.center,    //alignment of the text
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                  )
              ),
            )
        )
    );

  }

}