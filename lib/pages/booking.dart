import 'dart:ui';
import 'package:barberbooking/services/database.dart';
import 'package:barberbooking/services/shared_pref.dart';
import 'package:flutter/material.dart';

class Booking extends StatefulWidget {
  final String service;
  Booking(this.service);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String? name, image, email;

  getDataFromSharedPref()async{
    name = await SharedpreferenceHelper().getUserName();
    image = await SharedpreferenceHelper().getUserImage();
    email = await SharedpreferenceHelper().getUserEmail();
    setState(() {

    });
  }

  getOnLoading()async{
    await getDataFromSharedPref();
    setState(() {

    });
  }
  @override
  void initState() {
    getOnLoading();
    super.initState();
  }
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2b1615),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Let the\njourney begin",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "images/discount.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Text(
                widget.service,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              _buildDateTimeSelector(
                context,
                "Set a Date",
                Icons.calendar_today,
                "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                _selectDate,
              ),
              SizedBox(height: 20.0),
              _buildDateTimeSelector(
                context,
                "Set a Time",
                Icons.access_time,
                _selectedTime.format(context),
                _selectTime,
              ),
              SizedBox(height: 50.0),
              GestureDetector(
                onTap: () async{
                  Map<String, dynamic> userBookingMap={
                    "Service": widget.service,
                    "Date": "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}".toString(),
                    "Time": _selectedTime.format(context).toString(),
                    "User Name": name,
                    "Image": image,
                    "Email": email
                  };
                  await DatabaseMethods().addUserBooking(userBookingMap).then((value){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Service has been booked Successfully!",style: TextStyle(fontSize: 20.0),)));
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  decoration: BoxDecoration(
                    color: Color(0xfffe8f33),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "BOOK NOW",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
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
    );
  }

  Widget _buildDateTimeSelector(
      BuildContext context,
      String label,
      IconData icon,
      String value,
      Future<void> Function(BuildContext) onTap,
      ) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color(0xFFb4817e),
        borderRadius: BorderRadius.circular(20.0),
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => onTap(context),
                child: Icon(icon, color: Colors.white, size: 30),
              ),
              SizedBox(width: 20.0),
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
