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
    bool isFlush = _isFlush();
    bool isStraight = _isStraight();
    if (isFlush && isStraight && _cards[0].rank == 8) {
      return 'Royal Flush';
    }
    else if (isFlush && isStraight) {
      return 'Straight Flush';
    }
    else if (counts.length == 1 && counts[0] == 4) {
      return 'Four of a Kind';
    }
    else if (counts.length == 2 && (
        (counts[0] == 3 && counts[1] == 2) ||
        (counts[0] == 2 && counts[1] == 3))
    ) {
      return 'Full House';
    }
    else if (isFlush && !isStraight) {
      return 'Flush';
    }
    else if (!isFlush && isStraight) {
      return 'Straight';
    }
    else if (counts.length == 1 && counts[0] == 3) {
      return 'Three of a Kind';
    }
    else if (counts.length == 2 && counts[0] == 2 && counts[1] == 2) {
      return 'Two Pair';
    }
    else if (counts.length == 1 && counts[0] == 2) {
      return 'Pair';
    }
    else {
      return 'High Card';
    }
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
    for (int i = 1; i < _cards.length; i++) {
        if (_cards[i].suit != _cards[0].suit) {
          return false;
        }
    }
    return true;
  }
  bool _isStraight() {
    int curRank = _cards[0].rank;
    int nextRank = _cards[1].rank;
    // check from cards 0 -> 3rd last card
    for (int i = 0; i < _cards.length-2; i++) {
        curRank = _cards[i].rank;
        nextRank = _cards[i+1].rank;
        if (curRank + 1 != nextRank) {
          return false;
        }
    }
    // update curRank to be the 2nd last card
    curRank = nextRank;
    if (_cards.last.rank == 12 && (curRank == 11 || curRank == 3)) {
      return true;
    }
    if (curRank+1 == _cards.last.rank) {
      return true;
    }
    return false;
  }

  void shuffle() {
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
    // Begin testing area

    // Royal Flush:
    // _cards = [Card(32), Card(36), Card(40), Card(44), Card(48)];

    // Straight Flush:
    // _cards = [Card(0), Card(4), Card(8), Card(12), Card(48)];

    // Four of a Kind:
    // _cards = [Card(0), Card(1), Card(2), Card(3), Card(4)];

    // Full House:
    // _cards = [Card(0), Card(1), Card(2), Card(4), Card(5)];

    // Flush:
    // _cards = [Card(5), Card(17), Card(25), Card(33), Card(45)];

    // Straight:
    // _cards = [Card(32), Card(37), Card(42), Card(47), Card(48)];

    // Straight:
    // _cards = [Card(0), Card(5), Card(10), Card(15), Card(48)];

    // Straight:
    // _cards = [Card(25), Card(28), Card(32), Card(36), Card(40)];

    // Three of a Kind:
    // _cards = [Card(24), Card(25), Card(27), Card(36), Card(40)];

    // Two Pair:
    // _cards = [Card(24), Card(25), Card(36), Card(39), Card(40)];

    // Pair:
    // _cards = [Card(24), Card(25), Card(32), Card(39), Card(40)];

    // High Card:
    // _cards = [Card(12), Card(28), Card(32), Card(39), Card(40)];

    // End testing area

    _pokerHand = assignPokerHand();
  }

  String cardImage(int cardIndex) {
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
