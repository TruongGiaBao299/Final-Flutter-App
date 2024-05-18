import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> recentItems = [
    {
      "title": "Animal Sounds",
      "definition":
          "Different sounds made by various animals, such as a lion's roar, a cat's meow, and a dog's bark."
    },
    {
      "title": "Car Names",
      "definition":
          "Names of various car models from different manufacturers, like Tesla Model S, Ford Mustang, and Toyota Corolla."
    },
    {
      "title": "Countries and Capitals",
      "definition":
          "A list of countries and their respective capitals, such as France - Paris, Japan - Tokyo, and Brazil - Brasília."
    },
  ];

  final List<Map<String, String>> yesterdayItems = [
    {
      "title": "Musical Instruments",
      "definition":
          "Various types of musical instruments, including the piano, guitar, violin, and drums."
    },
    {
      "title": "Programming Languages",
      "definition":
          "Different programming languages used in software development, such as Python, JavaScript, Java, and C++."
    },
    {
      "title": "Fruits and Vegetables",
      "definition":
          "Common fruits and vegetables, including apples, oranges, carrots, and spinach."
    },
  ];

  final List<Map<String, String>> weekAgoItems = [
    {
      "title": "Historical Events",
      "definition":
          "Significant events in history, such as the signing of the Declaration of Independence, the fall of the Berlin Wall, and the moon landing."
    },
    {
      "title": "Planets in the Solar System",
      "definition":
          "The planets in our solar system, including Earth, Mars, Jupiter, and Saturn."
    },
    {
      "title": "Famous Scientists",
      "definition":
          "Notable scientists and their contributions, such as Albert Einstein, Marie Curie, and Isaac Newton."
    },
    {
      "title": "Art Movements",
      "definition":
          "Various art movements throughout history, including the Renaissance, Impressionism, and Modernism."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
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
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          buildCategorySection("Recent", recentItems),
          const SizedBox(height: 10),
          buildCategorySection("Yesterday", yesterdayItems),
          const SizedBox(height: 10),
          buildCategorySection("1 Week Ago", weekAgoItems),
        ],
      ),
    );
  }

  Widget buildCategorySection(String title, List<Map<String, String>> items) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
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
        const SizedBox(height: 10),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return SizedBox(
                width: 250,
                child: Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  color: Colors.white,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title']!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item['definition']!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
