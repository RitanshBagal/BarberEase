import 'package:barberbooking/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class onboarding extends StatefulWidget {
  const onboarding({super.key});

  @override
  State<onboarding> createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2b1615),
      body: Container(
        margin: EdgeInsets.only(top: 120),
        child: Column(
          children: [
              Image.asset('images/barber.png'),
            SizedBox(height: 50.0),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: Color(0xffdf711a),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                    "Get a Stylish HairCut",
                  style: TextStyle(color: Colors.white, fontSize: 22.0,fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
