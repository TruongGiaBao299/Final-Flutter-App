import 'package:exam/flashCard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flip_card/flip_card.dart';
import 'flashCard.dart';

class FlashCard extends StatefulWidget {
  const FlashCard({super.key});

  @override
  State<FlashCard> createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  List<FlashCardContainer> _flashCard = [
    FlashCardContainer(question: "Hello", answer: "Xin chào"),
    FlashCardContainer(question: "Good bye", answer: "Tạm biệt"),
    FlashCardContainer(question: "Eat", answer: "Ăn"),
    FlashCardContainer(question: "Drink", answer: "Uống"),
    FlashCardContainer(question: "Ice cream", answer: "Kem"),
    FlashCardContainer(question: "Salad", answer: "Xà lách"),
    FlashCardContainer(question: "Vegetable", answer: "Rau củ quả"),
  ];

  int _currentIndex = 0;

  void previousCard() {
    setState(() {
      _currentIndex = (_currentIndex - 1 > _flashCard.length)
          ? _currentIndex - 1
          : _flashCard.length - 1;
    });
  }

  void nextCard() {
    setState(() {
      _currentIndex =
          (_currentIndex + 1 < _flashCard.length) ? _currentIndex + 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlashCard'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                      TextSpan(
                          text: 'Note:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      TextSpan(
                          text:
                              'Try to remember the words before flashing the card',
                          style: TextStyle(fontSize: 20))
                    ])),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 400,
            height: 400,
            child: FlipCard(
              front:
                  FlashCardView(text: _flashCard[_currentIndex].question ?? ''),
              back: FlashCardView(text: _flashCard[_currentIndex].answer ?? ''),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              OutlinedButton.icon(
                  onPressed: previousCard,
                  icon: Icon(Icons.chevron_left),
                  label: Text('Prev')),
              SizedBox(
                width: 205,
              ),
              OutlinedButton.icon(
                  onPressed: nextCard,
                  icon: Icon(Icons.chevron_right),
                  label: Text('Next')),
            ],
          )
        ],
      ),
    );
  }
}
