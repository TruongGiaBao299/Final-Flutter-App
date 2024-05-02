import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 229, 232),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quizlet',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.notifications_none,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'View all',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 250,
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Yesterday',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'View all',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 250,
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1 week ago',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'View all',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 250,
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
