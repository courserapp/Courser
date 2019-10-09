/* This file contains basic UI components created for reusability */

import 'package:flutter/material.dart';

// From Courser
import 'package:courser/Course/course_desc.dart';
import 'package:courser/DB Interface/structures.dart';

// Generates a string title
/* Used at 
Add Courses page
Course Description page
*/

Widget titleGen(String title, double size, var weight, var tcolor) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      child: Text(
        title,
        style: TextStyle(
            color: tcolor,
            fontFamily: "Roboto",
            fontSize: size,
            fontWeight: weight),
      ),
    ),
  );
}

 // Generates a description
 /* Used at
 Course Description page
 */

Widget valueGen(String value) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      child: Text(
        value,
        style: TextStyle(
            color: Colors.black,
            fontFamily: "Roboto",
            fontSize: 18.0,
            fontWeight: FontWeight.w400),
      ),
    ),
  );
}

// Generates a Text Field
/* Used at 
Add Courses page



*/
Widget TFieldGen(String decoration) {
  return TextField(decoration: InputDecoration(hintText: decoration));
}

// Generates a Button
/* Used at 
Add Courses page



*/
Widget ButtonGen(
    BuildContext context, String buttonText, var textColor, var buttonColor) {
  return Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(10.0),
    color: buttonColor,
    child: MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () {},
      child: Text(buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 21.0, color: textColor)),
    ),
  );
}

// Generates a Secondary app bar (App bars for pages other than home page)
/* Used at 
Add Courses page



*/
Widget SecondaryAppBar(String title, GlobalKey<ScaffoldState> _scaffoldKey) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(color: Colors.deepPurple),
      textAlign: TextAlign.left,
    ),
    backgroundColor: Colors.white,
    centerTitle: true,
    elevation: 0.0,
    leading: IconButton(
      icon: Icon(
        Icons.menu,
        color: Colors.deepPurple,
      ),
      onPressed: () => _scaffoldKey.currentState.openDrawer(),
    ),
  );
}

/*Generates course cards on input of String list
Used at:
Home Page
Added Courses Page
Upvoted Courses Page


*/

String FindImage(String input){
  Map imageAddress = {
  'Kotlin': 'assets/images/k.jpeg',
  'Python':'assets/images/python.jpg',
  'C':'assets/images/c.jpg',
  'C++':'assets/images/cpp.jpg',
  'Web Develpoment':'assets/images/wd.jpeg',
  'Data Analysis':'assets/images/da.jpg',
  'Machine Learning':'assets/images/ML.jpg',
  //'Flutter':'assets/images/f.jpeg',
  'Java':'assets/images/j.png',

  };

  if (imageAddress[input] != null){
  return imageAddress[input];
  }

  else{
    return ('assets/images/python.jpg');
  }
}

Widget CourseCards(BuildContext context, List<Course> courseList, User currUser) {
  return GridView.count(
      crossAxisCount: 2,
      children: List.generate(courseList.length, (index) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CourseDesc(courseList[index], currUser)),
              );
            },
            child: Card(
                //color: Colors.black,
                child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
 
                  image: AssetImage(FindImage(courseList[index].type)),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: EdgeInsets.all(0.5),
                      child: Text(
                        courseList[index].cname,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                      ))),
            )));
      }));
}
