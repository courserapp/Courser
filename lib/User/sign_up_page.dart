import 'package:flutter/material.dart';

// Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

// From Courser
import 'package:courser/Pages/home_page.dart';
import 'package:courser/User/login_page.dart';
import 'package:courser/DB Interface/structures.dart';
import 'package:courser/Basic UI Components/basicUI.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

final FirebaseAuth mAuth = FirebaseAuth.instance;

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int maxUsers;

  @override
  Widget initState(){
    DatabaseReference dbref = FirebaseDatabase.instance.reference();
    dbref
        .child('users')
        .once()
        .then((DataSnapshot snap){
      this.maxUsers = snap.value.length;
    });
    setState(() {
      print(this.maxUsers);
    });

  }

  @override
  Widget build(BuildContext context) {
    // Header text 1
    final Welcome = Align(
      alignment: Alignment.center,
      child: Container(
        child: Text(
          "Welcome to Courser",
          style: TextStyle(
              color: Colors.deepPurple, fontFamily: "Roboto", fontSize: 22.0),
        ),
      ),
    );

    // Header text 2
    final SignUp = Align(
      alignment: Alignment.center,
      child: Container(
        child: Text(
          "Sign up to create an account",
          style: TextStyle(
              color: Colors.grey,
              fontFamily: "Raleway",
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
            return "Please type a password";
          }
        },
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))));

    final LButton = Material(
      elevation: 6.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.deepPurple,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          signup();
        },
        child: Text("CREATE ACCOUNT",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 21.0, color: Colors.white)),
      ),
    );

    final SignIn = GestureDetector(
      child: Align(
        alignment: Alignment.center,
        child: Container(
            child: Text(
          "ALREADY HAVE AN ACCOUNT? SIGN IN",
          style: TextStyle(
              fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        )),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
    );

    //Spacer
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
                SignUp,
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
                SignIn,
              ],
            ),
          ),
        ),
      ),
    )));
  }

// Creates new account on firebase
  void signup() async {
    FirebaseUser user;
    try {
      user = await mAuth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      DatabaseReference userref = FirebaseDatabase.instance.reference();
      List<int> cur = [0];
      userref.child('users').child('${this.maxUsers}').set({
        'uid':this.maxUsers,
        'uname':emailController.text,
        'revCourses':cur,
        'upvCourses':cur,
      });

      User currUser = User(maxUsers, emailController.text, [],[]);

      Navigator.push(
          context, MaterialPageRoute(builder: (BuildContext) => MyHomePage(currUser)));
    } catch (e) {
      print(e.toString());
    }
  }
}
