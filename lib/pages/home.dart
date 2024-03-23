// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:zorko/components/list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int userCoins = 100;
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            children: [
              // Background image
              // Positioned(
              //   top: 80, // Move the circle up by adjusting this value
              //   left: -100, // Optional: Adjust left position if needed
              //   child: Container(
              //     width: 600, // Adjust width of the circle if needed
              //     height: 600, // Adjust height of the circle if needed
              //     decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       gradient: LinearGradient(
              //         begin: Alignment.centerLeft,
              //         end: Alignment.centerRight,
              //         colors: [Color(0xFFFFCE92), Color(0xFFED8F03)],
              //       ),
              //     ),
              //   ),
              // ),
          
              // Text
              SizedBox(height: 10,),
              Positioned(
                top: 100,
                left: 0,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      
                      width: MediaQuery.of(context).size.width,
                      child: SearchAnchor(builder:
                          (BuildContext context, SearchController controller) {
                        return SearchBar(
                          controller: controller,
                          padding: const MaterialStatePropertyAll<EdgeInsets>(
                              EdgeInsets.symmetric(horizontal: 16.0)),
                          onTap: () {
                            controller.openView();
                          },
                          onChanged: (_) {
                            controller.openView();
                          },
                          leading: const Icon(Icons.search),
                          trailing: <Widget>[
                            const SizedBox(width: 8),
                            Tooltip(
                              message: 'Filter',
                              child: IconButton(
                                onPressed: () {
                                  // Handle filter button press
                                },
                                icon: const Icon(Icons.filter_list),
                              ),
                            )
                          ],
                        );
                      }, suggestionsBuilder:
                          (BuildContext context, SearchController controller) {
                        return List<ListTile>.generate(5, (int index) {
                          final String item = 'item $index';
                          return ListTile(
                            title: Text(item),
                            onTap: () {
                              setState(() {
                                controller.closeView(item);
                              });
                            },
                          );
                        });
                      }),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 200,
                      padding: EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      
                      decoration: BoxDecoration(
                        color: Colors.orange[300],
                        image: DecorationImage(image: AssetImage('assets/h8.png'),fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                    SizedBox(height: 10,),
                    FoodList(foodName: 'Burgers',fooditem: 'assets/h4.png',),
                    SizedBox(height: 10,),
                    FoodList(foodName: 'Drinks',fooditem: 'assets/h9.jpg',),
                    SizedBox(height: 10,),
                    FoodList(foodName: 'Desserts',fooditem: 'assets/h10.jpg',),
          
                  ],
                ),
              ),
            ],
          ),
      );
=======
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              children: [
                // Background image
                // Positioned(
                //   top: 80, // Move the circle up by adjusting this value
                //   left: -100, // Optional: Adjust left position if needed
                //   child: Container(
                //     width: 600, // Adjust width of the circle if needed
                //     height: 600, // Adjust height of the circle if needed
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       gradient: LinearGradient(
                //         begin: Alignment.centerLeft,
                //         end: Alignment.centerRight,
                //         colors: [Color(0xFFFFCE92), Color(0xFFED8F03)],
                //       ),
                //     ),
                //   ),
                // ),
            
                // Text
                SizedBox(height: 10,),
                Positioned(
                  top: 100,
                  left: 0,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        
                        width: MediaQuery.of(context).size.width,
                        child: SearchAnchor(builder:
                            (BuildContext context, SearchController controller) {
                          return SearchBar(
                            controller: controller,
                            padding: const MaterialStatePropertyAll<EdgeInsets>(
                                EdgeInsets.symmetric(horizontal: 16.0)),
                            onTap: () {
                              controller.openView();
                            },
                            onChanged: (_) {
                              controller.openView();
                            },
                            leading: const Icon(Icons.search),
                            trailing: <Widget>[
                              const SizedBox(width: 8),
                              Tooltip(
                                message: 'Filter',
                                child: IconButton(
                                  onPressed: () {
                                    // Handle filter button press
                                  },
                                  icon: const Icon(Icons.filter_list),
                                ),
                              )
                            ],
                          );
                        }, suggestionsBuilder:
                            (BuildContext context, SearchController controller) {
                          return List<ListTile>.generate(5, (int index) {
                            final String item = 'item $index';
                            return ListTile(
                              title: Text(item),
                              onTap: () {
                                setState(() {
                                  controller.closeView(item);
                                });
                              },
                            );
                          });
                        }),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 200,
                        padding: EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width,
                        
                        decoration: BoxDecoration(
                          color: Colors.orange[300],
                          image: DecorationImage(image: AssetImage('assets/h8.png'),fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      SizedBox(height: 10,),
                      FoodList(foodName: 'Burgers'),
                      SizedBox(height: 10,),
                      FoodList(foodName: 'Drinks'),
                      SizedBox(height: 10,),
                      FoodList(foodName: 'Desserts'),
                    ],
                  ),
                ),
              ],
            ),
        ),
    );
>>>>>>> Stashed changes
  }
}