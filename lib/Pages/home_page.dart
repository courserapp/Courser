import 'dart:developer';

import 'package:flutter/material.dart';

// From Courser
import "package:courser/Basic UI Components/drawer.dart";
import 'package:courser/Basic UI Components/basicUI.dart';
import 'package:courser/DB Interface/structures.dart';
import 'package:courser/Course/course_desc.dart';

// Firebase
import 'package:firebase_database/firebase_database.dart';

class MyHomePage extends StatefulWidget {

  User currUser;

  MyHomePage(User us){
    this.currUser = us;
  }

  @override
  _MyHomePageState createState() => _MyHomePageState(this.currUser);
}

class _MyHomePageState extends State<MyHomePage> {
  List<Course> c1 = [];
  List<String> cnameList = [];
  User currUser;

  _MyHomePageState(User u){
    this.currUser = u;
  }
  /*
  MyHomePage(List<Course> courseList) {
    this.c1 = courseList;
  }
  
  */
  @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref
        .child('courses')
        .once()
        .then((DataSnapshot snap) {
      var data = snap.value;
      for (int i = 0; i < data.length; i++) {
        Course c;
        c = new Course(
          data[i]['cid'],
          data[i]['cname'],
          data[i]['uname'],
          data[i]['desc'],
          data[i]['type'],
          data[i]['link'],
          data[i]['platform'],
          data[i]['upvCount'],
          data[i]['price'],
          data[i]['prereq'],
        );
        this.c1.add(c);
        this.cnameList.add(data[i]['cname']);
        print('$c');
      }
      setState(() {
        print('length ${c1.length}');
      });
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Home page

    // App bar of home page
    final topBar = AppBar(
      title: Text(
        'Courser',
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
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.deepPurple,
          ),
          onPressed: () {
            showSearch(context: context, delegate: DataSearch(this.cnameList, this.c1, this.currUser));
          },
        )
      ],
    );

    // Generates grid of courses taking input the list of courses

    // Adds title to grid of courses
    Widget TitleCourseCards(String listTitle, List<String> itemList) {
      return Row(children: <Widget>[
        new Expanded(
            child: Column(children: <Widget>[
          SizedBox(height: 10.0),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                listTitle,
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              )),
          SizedBox(
            height: 10.0,
          ),
          new Expanded(child: CourseCards(context, c1, this.currUser)),
        ]))
      ]);
    }

    // Replace with list of courses in interests
    List<String> itemList = [
      "Python for Everybody Specialization",
      "Programming for Everybody (Getting Started with Python)",
      "Python Data Structures",
      "Applied Data Science with Python Specialization",
      "Introduction to Data Science in Python",
      "Python 3 Programming Specialization",
    ];

    return Scaffold(
        key: _scaffoldKey,
        appBar: topBar,
        drawer: AppDrawer(this.currUser),
        body: Padding(
            padding: EdgeInsets.all(15.0),
            child: CourseCards(context, c1, this.currUser)));//TitleCourseCards("Recommendations for you", itemList)));
  }
}

class DataSearch extends SearchDelegate {
  List<String> cnameList;
  List<Course> courseList;
  User currUser;

  DataSearch(List<String> input, List<Course> input2, User input3) {
    this.cnameList = input;
    this.courseList = input2;
    this.currUser = input3;
  }

  Course findCourse(String courseName, List<Course> courseList){

    Course foundCourse;

    for(int i=0; i<courseList.length; i++){
      if(courseList[i].cname == courseName){
        foundCourse =  courseList[i];
        break;
      }

      else{
        continue;
      }
    }
    return foundCourse;
  }

  List<String> popCourses = [
    'Python for Everybody Specialization',
    'Programming for Everybody (Getting Started with Python)',
    'Python Data Structures',
    'Applied Data Science with Python Specialization',
    'Introduction to Data Science in Python'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }


  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults

    List<String> results = cnameList.where((p) => p.startsWith(query)).toList();
    return ListView.builder(itemBuilder: (context, index) {
      return GestureDetector(
          onTap: (){
              Course tempCourse = findCourse(results[index], courseList);
              Navigator.push(context, MaterialPageRoute(builder: (context){return CourseDesc(tempCourse, this.currUser);}));
          },
          child:Container(
              height: 100.0,
              child: Card(

        child: Center(
          child: Text(results[index]),
        ),
      )));
    },
    itemCount: results.length,);
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions


    final suggestions = query.isEmpty
        ? popCourses
        : cnameList.where((p) => p.startsWith(query)).toList();
    List<String> results = cnameList.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Course tempCourse = findCourse(results[index], courseList);
            Navigator.push(context, MaterialPageRoute(builder: (context){return CourseDesc(tempCourse, this.currUser);}));
            //showResults(context);
          },
          title: Text(suggestions[index]),
        );
      },
      itemCount: suggestions.length,
    );
  }
}
