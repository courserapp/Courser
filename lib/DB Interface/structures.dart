class Course {
  /* stores data of course

     purpose: to store and retrieve data related to course
     */

  int cid; // Unique id of courses
  String cname; // course name
  String uname; //user name
  String desc; //description
  String type; //type of course
  String link; //link of course
  String platform; //platform providing course(like udemy,coursera)
  int upvCount; //no. of upvotes/likes on course
  String price; // String "Free" or "Paid"
  String preReq; //Prerequisites for course

  //Constructor for Course
  Course(int cid, String cname, String uname, String desc,
      String type, String link, String platform, int upvCount, String price, String preReq) {
    this.cid = cid;
    this.cname = cname;
    this.uname = uname;
    this.desc = desc;
    this.type = type;
    this.link = link;
    this.platform = platform;
    this.upvCount = upvCount;
    this.price = price;
    this.preReq = preReq;
  }

  ConsoleDisplay(){
    print("Course ID : ${this.cid}");
    print("Course Name : ${this.cname}");
    print("User Name : ${this.uname}");
    print("Description : ${this.desc}");
    print("Type : ${this.type}");
    print("Link : ${this.link}");
    print("Platform : ${this.platform}");
    print("Upvotes : ${this.upvCount}");
    print("Price : ${this.price}");
    print("Pre Requisites : ${this.preReq}");
  }

  Course loadData(Map fetchedData){
    try {
      fetchedData['cid'] = this.cid;
      fetchedData['cname'] = this.cname;
      fetchedData['uname'] = this.uname;
      fetchedData['desc'] = this.desc;
      fetchedData['type'] = this.type;
      fetchedData['link'] = this.link;
      fetchedData['platform'] = this.platform;
      fetchedData['upvcount'] = this.upvCount;
      fetchedData['preReq'] = this.preReq;
    }
    catch (e){
      print(e);
    }
  }

  void flush(){
    print('Added to database');
    //TODO: Write code for adding entry to database
  }
}

class CourseReview {
  int cid; //course id
  String uname; //user name
  String review; //review on course

  //constructor for CourseReview
  CourseReview(int cid, String uname, String review) {
    this.cid = cid;
    this.uname = uname;
    this.review = review;
  }

  CourseReview loadData(Map fetchedData){
    fetchedData['cid'] = this.cid;
    fetchedData['uname'] = this.uname;
    fetchedData['review'] = this.review;
  }

}

class User {
  int uid; //user id
  String uname; //user name
  //List<int> addedCourses; //courses added  by user
  List<int> upvotedCourses; //courses upvoted by user
  List<int> reviewedCourses; //courses reviewed by user
  /*String interest1;  //first interest
  String interest2;  //second interest
  String interest3;*/ //third interest

  //constructor User
  User(int uid, String uname,
      List<int> upvotedCourses, List<int> reviewedCourses,) {
    this.uid = uid;
    this.uname = uname;

    this.upvotedCourses = upvotedCourses;
    this.reviewedCourses = reviewedCourses;
  }
/*
  User fetchData(Map fetchedData){
    fetchedData['uid'] = this.uid;
    fetchedData['uname'] = this.uname;
    fetchedData['addedCourses'] = this.addedCourses;
    fetchedData['upvotedCourses'] = this.upvotedCourses;
    fetchedData['reviewCourses'] = this.reviewedCourses;
    fetchedData['interest1'] = this.interest1;
    fetchedData['interest2'] = this.interest2;
    fetchedData['interest3'] = this.interest3;
  }
}
*/
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

String iffree(int value){
  if (value == 0){
    return('Paid');
  }

  else if (value==1){
    return("Free");
  }

  else {
    return(null);
  }

}