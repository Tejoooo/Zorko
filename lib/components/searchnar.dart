import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController _controller;
  String? _searchQuery;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _performSearch() {
    setState(() {
      _searchQuery = _controller.text;
    });
    // Perform search functionality here
  }

  void _resetSearch() {
    setState(() {
      _controller.clear();
      _searchQuery = null;
    });
    // Reset search functionality here
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: _performSearch,
              child: Text('Search'),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: _resetSearch,
              child: Text('Reset'),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                // Perform filter functionality here
              },
              child: Text('Filter'),
            ),
          ],
        ),
        SizedBox(height: 16),
        _searchQuery != null
            ? Text('Search query: $_searchQuery')
            : SizedBox(),
      ],
    );
  }
}