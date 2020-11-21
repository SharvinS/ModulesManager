import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cgpa_calculator_assignment/coursedb.dart';
import 'package:cgpa_calculator_assignment/database.dart';
import 'package:flutter/services.dart';

class GPAcalc extends StatefulWidget {
  final int n;
  final int sem;
  GPAcalc(this.n, this.sem);

  @override
  GPAcalcstate createState() => new GPAcalcstate();
}

class GPAcalcstate extends State<GPAcalc> {
  List<String> _dGrade = ['A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-'].toList();
  List<String> _dCreditHour = ['1', '2', '3', '4', '5', '6', '7', '8'].toList();

  var _grade;
  var _CodeCp;
  var _creditHour;
  var _subjectCode;
  var list;
  String semString;
  String resgpa;
  String reschr;

  @override
  void initState() {
    super.initState();
    _grade = new List<String>()..length = widget.n;
    _CodeCp = new List<TextEditingController>()..length = widget.n;
    _creditHour = new List<String>()..length = widget.n;
    _subjectCode = new List<String>()..length = widget.n;
    list = new List<int>.generate(widget.n, (i) => i);
  }

  @override
  Widget build(BuildContext context) {
    double sogxc = 0, soc = 0;
    var textFields = <Widget>[];
    bool safeToNavigate = true;

    textFields.add(
      new Row(children: [
        new Padding(
          padding: new EdgeInsets.only(left: 20.0),
        ),
        new Column(children: [
          new Text(
            "     Code",
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          ),
        ]),
        new Padding(
          padding: new EdgeInsets.only(left: 35.0),
        ),
        new Column(children: [
          new Text(
            "  Grade",
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          ),
        ]),
        new Padding(
          padding: new EdgeInsets.only(left: 45.0),
        ),
        new Column(
          children: [
            new Text(
              "  Credits",
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ),
          ],
        ),
        new Padding(
          padding: new EdgeInsets.only(bottom: 25.0),
        ),
      ]),
    );
    list.forEach((i) {
      textFields.add(
        new Column(
          children: [
            new Row(children: [
              new Padding(
                padding: new EdgeInsets.all(15.0),
              ),
              new Container(
                height: 50.0,
                width: 50.0,
                child: TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  decoration: new InputDecoration(
                    hintText: "Code ${i + 1}",
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                  ],
                  controller: _CodeCp[i],
                  onChanged: (s) {
                    setState(() {
                      _subjectCode[i] = (_CodeCp[i]).toString();
                      _subjectCode[i] = s;
                    });
                  },
                ),
              ),
              new Padding(
                padding: new EdgeInsets.all(15.0),
              ),
              new DropdownButton<String>(
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                hint: new Text(
                  "Grade ${i + 1}",
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.normal),
                ),
                value: _grade[i],
                items: _dGrade.map((String item) {
                  return new DropdownMenuItem<String>(
                    value: item,
                    child: new Text(
                      item,
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
                onChanged: (s) {
                  setState(() {
                    _grade[i] = s;
                  });
                },
              ),
              new Padding(
                padding: new EdgeInsets.all(15.0),
              ),
              new DropdownButton<String>(
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                hint: new Text(
                  "Credit ${i + 1}",
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.normal),
                ),
                value: _creditHour[i],
                items: _dCreditHour.map((String items) {
                  return new DropdownMenuItem<String>(
                    value: items,
                    child: new Text(
                      items,
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
                onChanged: (s) {
                  setState(() {
                    _creditHour[i] = s;
                  });
                },
              ),
            ]),
          ],
        ),
      );
    });

    double res = 0.0;

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("MODULES MANAGER"),
          backgroundColor: Colors.blue[800],
        ),
        body: Material(
            child: new Container(
              color: Colors.black26,
              padding: EdgeInsets.all(30.0),
              child: new ListView(
                children: textFields,
              ),
            )
        ),
        floatingActionButton: new Material(
          borderRadius: BorderRadius.circular(50.0),
          elevation: 10.0,
          child: new MaterialButton(
            color: Colors.blue[800],
            height: 50.0,
            minWidth: 80.0,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () async {
              semString = (widget.sem).toString();
              await CoursedbDatabaseProvider.db
                  .deleteGPAdbWithSemester(semString);
              await CoursedbDatabaseProvider.db
                  .deleteCoursedbWithSemester(semString);

              for (int i = 0; i < widget.n; i++) {
                if (_creditHour[i] == null) {
                  safeToNavigate = false;
                  continue;
                }
                if (_grade[i] == null) {
                  safeToNavigate = false;
                  continue;
                }
                if (_subjectCode[i] == null) {
                  safeToNavigate = false;
                  continue;
                }

                double r = double.parse(_creditHour[i]);
                double gp = calculate(_grade[i]);
                double cp = r;
                double gxc = gp * cp;
                sogxc += gxc;
                soc += cp;

                Coursedb rnd = Coursedb(
                    semester: semString,
                    code: _subjectCode[i],
                    credit: _creditHour[i],
                    grade: _grade[i]);

                await CoursedbDatabaseProvider.db.addCoursedbToDatabase(rnd);
              }

              if (safeToNavigate == true) {
                res = sogxc / soc;

                resgpa = (res).toStringAsFixed(2);
                reschr = (soc).toString();

                GPAdb rna =
                    GPAdb(semester: semString, gpa: resgpa, chr: reschr);

                await CoursedbDatabaseProvider.db.addGPAdbToDatabase(rna);
                alert2();
              } else {
                alert();
              }
              setState(() {});
            },
            child: new Text('Calculate'),
          ),
        ));
  }

  double calculate(var a) {
    if (a == "A") return 4.0;
    if (a == "A-") return 3.7;
    if (a == "B+") return 3.3;
    if (a == "B") return 3.0;
    if (a == "B-") return 2.7;
    if (a == "C+") return 2.3;
    if (a == "C") return 2.0;
    if (a == "C-") return 1.7;
    return 0;
  }

  Future<Null> alert() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Error'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('Input all the data'),
              ],
            ),
          ),
          actions: <Widget>[
            new RaisedButton(
              elevation: 5.0,
              color: Colors.blue[800],
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

  Future<Null> alert2() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Your GPA for this semester is:'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text(resgpa),
              ],
            ),
          ),
          actions: <Widget>[
            new RaisedButton(
              elevation: 5.0,
              color: Colors.blue[800],
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
