import 'package:barberbooking/services/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:barberbooking/pages/booking.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String? name, image;

  getDataFromSharedPref()async{
    name = await SharedpreferenceHelper().getUserName();
    image = await SharedpreferenceHelper().getUserImage();
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2b1615),
      body: Container(
        margin: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello,',
                      style: TextStyle(
                        color: Color.fromARGB(297, 255, 255, 255),
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      name ?? 'User',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: image != null
                      ? Image.network(
                    image!,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  )
                      : Container(
                    height: 60,
                    width: 60,
                    color: Colors.grey,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 20.0),
            Divider(color: Colors.white30),
            SizedBox(height: 20.0),
            Text(
              'Services',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            // Services Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                children: [
                  _buildServiceItem(
                    context,
                    "Classic Shaving",
                    "images/shaving.png",
                  ),
                  _buildServiceItem(
                    context,
                    "Hair Wash",
                    "images/hair.png",
                  ),
                  _buildServiceItem(
                    context,
                    "Hair Cutting",
                    "images/cutting.png",
                  ),
                  _buildServiceItem(
                    context,
                    "Beard Trimming",
                    "images/beard.png",
                  ),
                  _buildServiceItem(
                    context,
                    "Facials",
                    "images/facials.png",
                  ),
                  _buildServiceItem(
                    context,
                    "Kids HairCut",
                    "images/kids.png",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context, String title, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Booking(title)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffe29452),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 80.0, width: 80.0, fit: BoxFit.cover),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
