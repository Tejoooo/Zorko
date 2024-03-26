// ignore_for_file: unused_field, library_private_types_in_public_api, unnecessary_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreens extends StatefulWidget {
  @override
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 2,
            color: Colors.orange, // Orange line
            width: MediaQuery.of(context).size.width /
                3, // Divide by number of pages
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width /
                    6), // Margin for each side
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                buildPage('We provide the fastest delivery', 'assets/h2.png'),
                buildPage('We provide the fastest delivery', 'assets/h3.png'),
                buildPage('We have a good system', 'assets/h4.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage(String content, String imagePath) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath),
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/h5.png'),
              SizedBox(
                height: 10,
              ),
              Text(
                content,
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 53,
                width: 280,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(10), // Set the border radius
                    color:
                        Color(0xFFEF7931), // Set the background color to EF7931
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your onPressed logic here
                      Navigator.pushNamed(context, "/login");
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.all(8), // Adjust padding as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the border radius as needed
                      ),
                      elevation: 0, // Set text color
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => _currentPage == index ? SplashScreenDot(active: true) : SplashScreenDot(active: false),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class SplashScreenDot extends StatelessWidget {
  bool active;
  SplashScreenDot({super.key,required this.active});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: active ? Color(0xFFEF7931) : Colors.grey,
              width: 6,
            ),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
