import 'package:flutter/material.dart';

// From Courser
import 'package:courser/Basic UI Components/drawer.dart';
import 'package:courser/Basic UI Components/basicUI.dart';
import 'package:courser/DB Interface/structures.dart';

Course currCourse = Course(
    11,
    "Advanced Python Programming",
    'Developer',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    'Python',
    'https://www.example.com',
    'Udacity',
    12,
    'Free',
    "Somethign link");
Course currCourse2 = Course(
    11,
    "Advanced Python Programming 2",
    'Developer',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    'Python',
    'https://www.example.com',
    'Udacity',
    12,
    'Free',
    "HTML");
Course currCourse3 = Course(
    11,
    "Advanced Python Programming 3",
    'Developer',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    'Python',
    'https://www.example.com',
    'Udacity',
    12,
    'Free',
    "CSS");
Course currCourse4 = Course(
    11,
    "Advanced Python Programming 4 ",
    'Developer',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    'Python',
    'https://www.example.com',
    'Udacity',
    12,
    'Free',
    "JS");
List<Course> courseList = [currCourse, currCourse2, currCourse3, currCourse4];

class AddedCourses extends StatefulWidget {

  User currUser;

  AddedCourses(User u){
    this.currUser = u;
  }

  @override
  _AddedCourseState createState() => _AddedCourseState(this.currUser);
}

class _AddedCourseState extends State<AddedCourses> {

  User currUser;

  _AddedCourseState(User u){
    this.currUser = u;
  }
  // TODO : Courses added by user
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<String> itemList = [
    "Python for Everybody Specialization",
    "Programming for Everybody (Getting Started with Python)",
    "Python Data Structures"
  ];

  @override
  Widget build(BuildContext context) {
    // Appbar of added courses page
    final topBar = SecondaryAppBar('Courses added by you', _scaffoldKey);

    final addedCourses = CourseCards(context, courseList, this.currUser);

    return Scaffold(
      key: _scaffoldKey,
      appBar: topBar,
      drawer: AppDrawer(this.currUser),
      body: addedCourses,
    );
  }
}
