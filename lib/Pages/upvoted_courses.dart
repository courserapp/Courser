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

class UpvCourses extends StatefulWidget {

  User currUser;

  UpvCourses(User u){
    this.currUser = u;
  }

  @override
  _UpvCourseState createState() => _UpvCourseState(this.currUser);
}

class _UpvCourseState extends State<UpvCourses> {

  User currUser;

  _UpvCourseState(User u){
    this.currUser = u;
  }
  // TODO : Courses upvoted by user
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<String> itemList = [
    "Applied Data Science with Python Specialization",
    "Introduction to Data Science in Python",
    "Python 3 Programming Specialization",
  ];

  @override
  Widget build(BuildContext context) {
    // Appbar of added courses page
    final topBar = SecondaryAppBar('Courses upvoted by you', _scaffoldKey);

    final upvotedCourses = CourseCards(context, courseList, currUser);

    return Scaffold(
      key: _scaffoldKey,
      appBar: topBar,
      drawer: AppDrawer(currUser),
      body: upvotedCourses,
    );
  }
}
