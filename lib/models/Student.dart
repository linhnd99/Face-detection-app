class Student {
  int userID;
  String usercode;
  String fullName;
  int classID;
  int facultyID;
  String phone;
  String dob;
  int courseID;

  Student({this.classID,this.courseID,this.dob,this.facultyID,this.fullName,this.phone,this.usercode,this.userID});

  Student.fromJson(Map<String,dynamic> json) {
    userID = json['UserID'];
    usercode = json['Usercode'];
    fullName = json['FullName'];
    classID = json['ClassID'];
    facultyID = json['FacultyID'];
    phone = json['Phone'];
    dob = json['Dob'];
    courseID = json['CourseID'];
  }

  Map<String,dynamic> toJson() {
    Map<String,dynamic> data = new Map<String,dynamic>();
    data['UserID'] = userID;
    data['Usercode'] = usercode;
    data['FullName'] = fullName;
    data['ClassID'] = classID;
    data['FacultyID'] = facultyID;
    data['Phone'] = phone;
    data['Dob'] = dob;
    data['CourseID'] = courseID;
  }
}