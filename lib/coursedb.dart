class Coursedb {
  int id;
  String semester;
  String code;
  String credit;
  String grade;

  Coursedb({this.id, this.semester, this.code, this.credit, this.grade});

  factory Coursedb.fromMap(Map<String, dynamic> json) => new Coursedb(
    id: json["id"],
    semester: json["semester"],
    code: json["code"],
    credit: json["credit"],
    grade: json["grade"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "semester": semester,
    "code": code,
    "credit": credit,
    "grade": grade,
  };
}

class GPAdb {
  int id;
  String semester;
  String gpa;
  String chr;

  GPAdb({this.id, this.semester, this.gpa, this.chr});

  factory GPAdb.fromMap(Map<String, dynamic> json) => new GPAdb(
    id: json["id"],
    semester: json["semester"],
    gpa: json["gpa"],
    chr: json["chr"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "semester": semester,
    "gpa": gpa,
    "chr": chr,
  };
}