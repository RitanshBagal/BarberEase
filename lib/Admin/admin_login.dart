import 'package:barberbooking/Admin/booking_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {

  TextEditingController adminNameController = new TextEditingController();
  TextEditingController adminPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 40, left: 10),
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 2,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
                  "Admin\nPanel ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery
                    .of(context)
                    .size
                    .height / 4,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 30.0),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height - (MediaQuery
                      .of(context)
                      .size
                      .height / 4),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Form(
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter your E-Mail';
                            }
                            return null;
                          },
                          controller: adminNameController,
                          decoration: InputDecoration(
                            hintText: "Admin's Name",
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
                          controller: adminPassword,
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
                          onTap: () {
                            loginAdmin();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
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
                                "LOG IN",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
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

  loginAdmin() {
    // Validate if the input fields are not empty
    if (adminNameController.text.isEmpty || adminPassword.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Enter Credentials Carefully!"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      bool isValidAdmin = false;

      snapshot.docs.forEach((result) {
        String adminId = result.data()['id'];
        String adminPass = result.data()['password'];

        if (adminNameController.text.trim() == adminId) {
          if (adminPassword.text.trim() == adminPass) {
            isValidAdmin = true;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookingAdmin()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Incorrect Password",
                  style: TextStyle(fontSize: 20.0),
                ),
                duration: Duration(seconds: 2),
              ),
            );
          }
        }
      });

      if (!isValidAdmin) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Admin Invalid!",
              style: TextStyle(fontSize: 20.0),
            ),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${error.toString()}"),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }
}
