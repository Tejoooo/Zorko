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
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
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
                  FoodList(),
                  SizedBox(height: 10,),
                  FoodList(),
                  SizedBox(height: 10,),
                  FoodList(),
                ],
              ),
            ),
          ],
        ),
      );
  }
}