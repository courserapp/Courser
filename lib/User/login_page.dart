import 'package:flutter/material.dart';

// Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

// From Courser
import 'package:courser/Pages/home_page.dart';
import 'package:courser/User/sign_up_page.dart';
import 'package:courser/Basic UI Components/basicUI.dart';
import 'package:courser/DB Interface/structures.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

final FirebaseAuth mAuth = FirebaseAuth.instance;

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextStyle style = TextStyle(fontFamily: 'Roboto', fontSize: 20.0);

  User currUser;

  @override
  Widget build(BuildContext context) {
    // Header text 1
    final Welcome = Align(
      alignment: Alignment.center,
      child: Container(
        child: Text(
          "Welcome to Courser",
          style: TextStyle(
              color: Colors.deepPurple, fontFamily: "Roboto", fontSize: 21.0),
        ),
      ),
    );

    // Header text 2
    final SignIn = Align(
      alignment: Alignment.center,
      child: Container(
        child: Text(
          "Sign in to continue",
          style: TextStyle(
              color: Colors.grey,
              fontFamily: "Roboto",
              fontSize: 14.0,
              fontWeight: FontWeight.w400),
        ),
      ),
    );

    final EmailText = titleGen("Email", 12.0, FontWeight.bold, Colors.grey);

    final EField = TextFormField(
        controller: emailController,
        validator: (input) {
          if (input.isEmpty) {
            return "Please type an email";
          }
        },
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))));

    final PassWordText =
        titleGen("Password", 12.0, FontWeight.bold, Colors.grey);

    final PField = TextFormField(
      controller: passwordController,
      validator: (input) {
        if (input.isEmpty) {
          return "Please type an password";
        }
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
      obscureText: true,
    );

    // Login button
    final LButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.deepPurple,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () => signin(),
        child: Text("SIGN IN",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 21.0, color: Colors.white)),
      ),
    );

    // Sign Up for account text
    final SignUp = GestureDetector(
      child: Align(
        alignment: Alignment.center,
        child: Container(
            child: Text(
          "SIGN UP FOR AN ACCOUNT",
          style: TextStyle(
              fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        )),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpPage()),
        );
      },
    );

    // Spacer
    final spacer = SizedBox(
      height: 10.0,
    );

    return WillPopScope(
        onWillPop: () async => false,

        child:Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 35.0,
                ),
                Welcome,
                SizedBox(
                  height: 5.0,
                ),
                SignIn,
                SizedBox(
                  height: 255.0,
                ),
                EmailText,
                spacer,
                EField,
                spacer,
                PassWordText,
                spacer,
                PField,
                spacer,
                LButton,



                spacer,
                SignUp,
              ],
            ),
          ),
        ),
      ),
    )));
  }

  // Authenticates sign in from Firebase
  void signin() async {
    FirebaseUser user;

    try {
      user = await mAuth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      DatabaseReference userref = FirebaseDatabase.instance.reference();

      userref.child('users').once().then((DataSnapshot snap){
        var data = snap.value;
        for (int i = 0; i < data.length; i++) {

          if(data[i]['uname']==emailController.text){
          this.currUser = User(
            data[i]['uid'],
            data[i]['uname'],
            data[i]['upvCourses'],
            data[i]['revCourses'],
          );

          break;
          }
          else{
            continue;
          }}});


      Navigator.push(
          context, MaterialPageRoute(builder: (BuildContext) => MyHomePage(this.currUser)));
    } catch (e) {
      print(e.toString());
    } finally {
      if (user != null) {
        print("User is signed in");
      }
    }
  }
}
