import 'package:barberbooking/pages/home.dart';
import 'package:barberbooking/pages/login.dart';
import 'package:barberbooking/services/database.dart';
import 'package:barberbooking/services/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:random_string/random_string.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String ?name, mail, password;

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController= new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration()async{
    if(password!= null && name != null && mail !=null){
      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: mail!, password:password!);

        String id = randomAlphaNumeric(10);
        await SharedpreferenceHelper().saveUserName(nameController.text);
        await SharedpreferenceHelper().saveUserEmail(emailController.text);
        await SharedpreferenceHelper().saveUserId(id);
        await SharedpreferenceHelper().saveUserImage("https://firebasestorage.googleapis.com/v0/b/barberapp-ebcc1.appspot.com/o/icon1.png?alt=media&token=0fad24a5-a01b-4d67-b");

        Map<String, dynamic> userInfoMap={
          "Name": nameController.text,
          "Email": emailController.text,
          "Id": id,
          "Image": "https://firebasestorage.googleapis.com/v0/b/barberapp-ebcc1.appspot.com/o/icon1.png?alt=media&token=0fad24a5-a01b-4d67-b"
        };
        await DatabaseMethods().addUserDetails(userInfoMap, id);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registered Successfully", style: TextStyle(fontSize: 20.0))));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
      }
      on FirebaseAuthException catch(e){
        if(e.code == 'weak-password'){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password provided is too weak", style: TextStyle(fontSize: 20.0))));
        }
        else if(e.code == 'email-already-in-use'){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Account already exists!", style: TextStyle(fontSize: 20.0))));
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 40, left: 10),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffb91635),
                      Color(0xff621d3c),
                      Color(0xff311937),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Text(
                  "Create Your\nAccount ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 4,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                  height: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height / 4),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(
                            color: Color(0xffb91635),
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Please Enter your Name';
                            }
                            return null;
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: "Name",
                            prefixIcon: Icon(Icons.person_outlined),
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          "Gmail",
                          style: TextStyle(
                            color: Color(0xffb91635),
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Please Enter your E-Mail';
                            }
                            return null;
                          },
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Gmail",
                            prefixIcon: Icon(Icons.mail_outline),
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          "Password",
                          style: TextStyle(
                            color: Color(0xffb91635),
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Please Enter Password';
                            }
                            return null;
                          },
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: "Passkey",
                            prefixIcon: Icon(Icons.password_outlined),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Color(0xff311937),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 60.0),
                        GestureDetector(
                          onTap: (){
                            if(_formkey.currentState!.validate()){
                              setState(() {
                                mail = emailController.text;
                                name = nameController.text;
                                password = passwordController.text;
                              });
                            }
                            registration();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xffb91635),
                                  Color(0xff621d3c),
                                  Color(0xff311937),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Spacer(), // Spacer added to push the text to the bottom
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: Color(0xff311937),
                                fontSize: 17.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>LogIn()));
                                    },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Color(0xff621d3c),
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
