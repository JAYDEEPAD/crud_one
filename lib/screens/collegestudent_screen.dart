
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main(){
runApp(MaterialApp(debugShowCheckedModeBanner: false, home: CollegeStudentScreen(),));
}

class CollegeStudentScreen extends StatefulWidget {
  const CollegeStudentScreen({super.key});

  @override
  State<CollegeStudentScreen> createState() => _CollegeStudentScreenState();
}

class _CollegeStudentScreenState extends State<CollegeStudentScreen> {

 late  String studentName,studentProgram,studentId;
 late double studentGPA;


 getStudentName(name){
   this.studentName=name;
 }

 getStudentID(id){
   this.studentId=id;
 }

 getStudentProgram(programId){
   this.studentProgram=programId;
 }

 getStudentGPA(gpa){
   this.studentGPA=double.parse(gpa);
 }

 createData(){
   print("create Data");
   DocumentReference documentReference=FirebaseFirestore.instance.collection("MyStudents").doc(studentName);
   //DocumentReference documentReference=FirebaseFirestore.instance.collection("MyStudents") as DocumentReference<Object?>;

   //create MAP
   Map<String, dynamic> students={
     "studentName":studentName,
     "studentID":studentId,
     "studentProgramId":studentProgram,
     "studentGPA":studentGPA,
   };
   documentReference.set(students).whenComplete(() => print("$studentName created"));
 }

 readData(){
   //print("read Data");


 /*  DocumentReference documentReference=FirebaseFirestore.instance.collection("MyStudents").doc(studentName);
   documentReference.get().then((datasnapshot){
     print(datasnapshot);
     print(datasnapshot.data());
     *//*print(datasnapshot.data["studentName"]);
     print(datasnapshot.data["studentID"]);
     print(datasnapshot.data["studentProgramID"]);
     print(datasnapshot.data["studentGPA"]);*//*
   });
*/
   /*documentReference.get().then((datasnapshot){
     print(datasnapshot.data['studentName']);
     print(datasnapshot.data['studentID']);
     print(datasnapshot.data["studentProgramID"]);
     print(datasnapshot.data["studentGPA"]);
   });*/
 }

 updateData(){

   DocumentReference documentReference=FirebaseFirestore.instance.collection("MyStudents").doc(studentName);

   //create MAP
   Map<String, dynamic> students={
     "studentName":studentName,
     "studentID":studentId,
     "studentProgramId":studentProgram,
     "studentGPA":studentGPA,
   };
   documentReference.set(students).whenComplete(() => print("$studentName updated"));


   print("update Data");

 }

 deleteData(){
   DocumentReference documentReference=FirebaseFirestore.instance.collection("MyStudents").doc(studentName);

   documentReference.delete().whenComplete(() => print("$studentName Deleted"));

   print("delete Data");
 }

 @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("My Flutter College"),
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Name",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0),),),
                onChanged: (String name){
                  getStudentName(name);
                },
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Student Id",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0),),),
                onChanged: (String studentId){
                  getStudentID(studentId);
                },
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Study Program",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0),),),
                onChanged: (String programId){
                  getStudentProgram(programId);
                },
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "GPA",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0),),),
                onChanged: (String gpa){
                    getStudentGPA(gpa);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    )
                  ),
                  onPressed: (){
                    createData();
                  },
                  child: Text("Create",style: TextStyle(color: Colors.white),),),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )
                  ),
                  onPressed: (){
                    readData();
                  },
                  child: Text("Read",style: TextStyle(color: Colors.white),),),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )
                  ),
                  onPressed: (){
                    updateData();
                  },
                  child: Text("Update",style: TextStyle(color: Colors.white),),),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )
                  ),
                  onPressed: (){
                    deleteData();
                  },
                  child: Text("Delete",style: TextStyle(color: Colors.white),),),
              ],
            ),
           StreamBuilder<QuerySnapshot>(
               stream: FirebaseFirestore.instance.collection("MyStudents").snapshots(),
               builder: (context,snapshot){
                 List <Row>studentWidgets=[];
                  if(snapshot.hasData) {
                    final studentsData = snapshot.data!.docs.reversed.toList();
                    for (var student in studentsData) {
                      final studentWidget = Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(student["studentName"]),
                          Text(student["studentID"]),
                          Text(student["studentProgramId"]),
                          Text(student["studentGPA"].toString()),
                        ],
                      );
                      studentWidgets.add(studentWidget);
                    }
                  }
                  return Expanded(
                   child: ListView(
                     children: studentWidgets,
                   ),
                 );
               })
          ],
        ),
      )
    );
  }
}



