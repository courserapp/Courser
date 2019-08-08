/* This file contains code for Course Description page */

import 'package:flutter/material.dart';

// From Courser
import 'package:courser/Basic UI Components/basicUI.dart';
import 'package:courser/DB Interface/structures.dart';
import 'package:courser/Course/course_reviews.dart';

// Firebase
import 'package:firebase_database/firebase_database.dart';

class CourseDesc extends StatefulWidget {
  Course c;
  User u;

  CourseDesc(Course c, User u) {
    this.c = c;
    this.u = u;
  }

  @override
  _CourseDescPage createState() => _CourseDescPage(this.c, this.u);
}

class _CourseDescPage extends State<CourseDesc> {
  Course currCourse; //current course
  User currUser;
  List<CourseReview> crList = [];
  int maxReviews;
  final reviewController = TextEditingController();

  _CourseDescPage(Course c1, User u1) {
    this.currCourse = c1;
    this.currUser = u1;
  }

  void initState() {
    DatabaseReference reviewRef = FirebaseDatabase.instance.reference();
    reviewRef.child('reviews').once().then((DataSnapshot snap) {
      var data = snap.value;
      for (int i = 0; i < data.length; i++) {
        if (data[i]['cid'] == currCourse.cid) {
          CourseReview tempCr;
          tempCr =
              CourseReview(data[i]['cid'], data[i]['uname'], data[i]['review']);
          this.crList.add(tempCr);
        } else {
          continue;
        }
      }
      setState(() {
        maxReviews = crList.length;
        print('length ${crList.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // App bar of Course page
    final courseDescBar = AppBar(
        title: Text(
          "Course Details",
          style: TextStyle(color: Colors.deepPurple),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.deepPurple,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ));

    // TODO: Return a picture according to type of course
    final courseImage = 0;

    final linkButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.deepPurple,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("LINK",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 21.0, color: Colors.white)),
      ),
    );

    final likeButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.white,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            //this.currCourse.upvCount = this.currCourse.upvCount + 1;
            DatabaseReference courseRef = FirebaseDatabase.instance.reference();
            courseRef
                .child('courses')
                .child('${this.currCourse.cid}')
                .update({'upvCount': (this.currCourse.upvCount + 1)});
            this.currUser.upvotedCourses.add(currCourse.cid);
            courseRef.child('users').child('${this.currUser.uid}').update({
              'upvCourses':this.currUser.upvotedCourses
            });
          },
          child: Icon(
            Icons.thumb_up,
            color: Colors.deepPurple,
          )),
    );

    final linkAndUpvote = Row(
      children: <Widget>[
        likeButton,
        SizedBox(
          width: 20.0,
        ),
        titleGen("${currCourse.upvCount}", 18.0, FontWeight.bold, Colors.black),

      ],
    );

    // Reviews
    final reviewBox = TextField(
      controller: reviewController,
        decoration: InputDecoration(hintText: "Add your comment here....."));

    final reviewSubButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.black,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          DatabaseReference reviewref = FirebaseDatabase.instance.reference();
          reviewref.child('reviews').child('${this.maxReviews}').set({
            'cid':currCourse.cid,
            'rid':maxReviews,
            'uname':currUser.uname,
            'review':reviewController.text
          });
        },
        child: Text('Submit Review',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 21.0, color: Colors.white)),
      ),
    );

    final reviewContainer = ReviewContainer(this.crList);

    final spacerCourseDesc = SizedBox(
      height: 20.0,
    );

    return Scaffold(
        appBar: courseDescBar,
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              titleGen(currCourse.cname, 32.0, FontWeight.bold, Colors.black),
              spacerCourseDesc,
              titleGen("Description", 18.0, FontWeight.bold, Colors.black),
              valueGen('${currCourse.desc}'),
              spacerCourseDesc,
              titleGen("Platform", 18.0, FontWeight.bold, Colors.black),
              valueGen(currCourse.platform),
              spacerCourseDesc,
              titleGen("Pre-Requisites", 18.0, FontWeight.bold, Colors.black),
              valueGen(currCourse.preReq),
              spacerCourseDesc,
              titleGen("Type", 18.0, FontWeight.bold, Colors.black),
              valueGen(currCourse.type),
              spacerCourseDesc,
              titleGen("Price", 18.0, FontWeight.bold, Colors.black),
              valueGen(currCourse.price),
              spacerCourseDesc,
              titleGen("Added by", 18.0, FontWeight.bold, Colors.black),
              valueGen(currCourse.uname),
              spacerCourseDesc,
              titleGen("Link to Course", 18.0, FontWeight.bold, Colors.black),
              valueGen(currCourse.link),
              spacerCourseDesc,
              titleGen("Add a review", 18.0, FontWeight.bold, Colors.black),
              reviewBox,
              spacerCourseDesc,
              reviewSubButton,
              SizedBox(height:30.0),
              titleGen("Reviews", 18.0, FontWeight.bold, Colors.black),
              reviewContainer
            ],
          ),
        )));
  }
}
