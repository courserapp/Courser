import 'package:flutter/material.dart';

// From Courser
import 'package:courser/DB Interface/structures.dart';
import 'package:courser/Basic UI Components/basicUI.dart';

class ReviewContainer extends StatelessWidget{

  List<CourseReview> cr;

  ReviewContainer(List<CourseReview> cr){
    this.cr = cr;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Make a review boxes

    try{
    return SizedBox(
        height: (100.0)*cr.length,
        child: ListView.builder(
            itemCount: cr.length,
            itemBuilder: (BuildContext context, index) {
              return Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Card(
                    elevation: 5.0,
                    child: Column(
                      children: <Widget>[
                        titleGen(cr[index].uname, 12.0, FontWeight.bold,
                            Colors.deepPurple),
                        Align(alignment: Alignment.centerLeft,child:Text(cr[index].review))
                      ],
                    ),
                  ));
            }));
  }
  catch(e){

    return SizedBox(height: 200.0,);
    }
  }
}