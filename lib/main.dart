import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.red,
      body: PokerPage(),
    ));
  }
}

class PokerPage extends StatefulWidget {
  @override
  _PokerPageState createState() => _PokerPageState();
}

class _PokerPageState extends State<PokerPage> {
  Hand hand = Hand();

  Widget drawCard(int cardIndex) {
    return Positioned(
      left: cardIndex * 40,
      child: Container(
        width: 200,
        height: 300,
        child: Image.asset('images/${hand.cardImage(cardIndex)}.png'),
      ),
    );
  }

  void shuffle() {
    setState(() {
      hand.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextButton(
          onPressed: () => shuffle(),
          child: Stack(
            children: <Widget>[
              Container(
                width: 360,
                height: 300,
                color: Colors.grey,
              ),
              drawCard(0),
              drawCard(1),
              drawCard(2),
              drawCard(3),
              drawCard(4),
            ],
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          hand.pokerHand,
          style: TextStyle(
            fontSize: 50.0,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ));
  }
}

class Hand {
  List<String> cardImages = [
    '2C',
    '2D',
    '2H',
    '2S',
    '3C',
    '3D',
    '3H',
    '3S',
    '4C',
    '4D',
    '4H',
    '4S',
    '5C',
    '5D',
    '5H',
    '5S',
    '6C',
    '6D',
    '6H',
    '6S',
    '7C',
    '7D',
    '7H',
    '7S',
    '8C',
    '8D',
    '8H',
    '8S',
    '9C',
    '9D',
    '9H',
    '9S',
    '10C',
    '10D',
    '10H',
    '10S',
    'JC',
    'JD',
    'JH',
    'JS',
    'QC',
    'QD',
    'QH',
    'QS',
    'KC',
    'KD',
    'KH',
    'KS',
    'AC',
    'AD',
    'AH',
    'AS'
  ];

  List<Card> _cards = [Card(31), Card(39), Card(43), Card(47), Card(51)];
  String _pokerHand = 'Flush';
  String get pokerHand => _pokerHand;

  String assignPokerHand() {
    List<int> counts = sameCardsList();
    if (counts.length == 1 && counts[0] == 4) {
      return 'Four of a Kind';
    }
    if (counts.length == 1 && counts[0] == 3) {
      return 'Three of a Kind';
    }
    if (counts.length == 2 && counts[0] == 2 && counts[1] == 2) {
      return 'Two Pair';
    }
    if (counts.length == 2 && (
        (counts[0] == 3 && counts[1] == 2) ||
        (counts[0] == 2 && counts[1] == 3))
    ) {
      return 'Full House';
    }
    if (counts.length == 2 && counts[0] == 2 && counts[1] == 2) {
      return 'Two Pair';
    }
    if (counts.length == 1 && counts[0] == 2) {
      return 'Pair';
    }
    else return 'High Card';
  }

  List<int> sameCardsList() {
    int prevRank;
    int curRank = _cards[0].rank;
    int count = 1;
    List<int> counts = [];
    for (int i = 1; i < _cards.length; i++) {
      prevRank = _cards[i - 1].rank;
      curRank = _cards[i].rank;
      if (curRank == prevRank) {
        count++;
      } else {
        if (count > 1) {
          counts.add(count);
          count = 1;
        }
      }
    }
    if (count > 1) {
      counts.add(count);
    }
    return counts;
  }

  bool _isFlush() {
    // TODO
    return false;
  }

  void shuffle() {
    // TODO
    List<int> cardIds = [];
    while (cardIds.length < 5) {
      int newId = Random().nextInt(52);
      bool idIsUnique = true;
      for (int i = 0; i < cardIds.length; i++) {
        if (cardIds[i] == newId) {
          idIsUnique = false;
        }
      }
      if (idIsUnique) {
        cardIds.add(newId);
      }
    }
    // _cards = cardIds.map((e) => Card(e)).toList();
    cardIds.sort();
    for (int i = 0; i < 5; i++) {
      _cards[i] = Card(cardIds[i]);
    }
    print(sameCardsList());
    _pokerHand = assignPokerHand();
  }

  String cardImage(int cardIndex) {
    // TODO
    return cardImages[_cards[cardIndex].id];
  }
}

class Card {
  int _id = 0;
  int _rank = 0;
  int _suit = 0;

  Card(int id) {
    _id = id;
    _rank = id ~/ 4;
    _suit = id % 4;
  }

  int get id => _id;
  int get rank => _rank;
  int get suit => _suit;
}
