List<String> cardImages = [
  '2C', '2D', '2H', '2S',
  '3C', '3D', '3H', '3S',
  '4C', '4D', '4H', '4S',
  '5C', '5D', '5H', '5S',
  '6C', '6D', '6H', '6S',
  '7C', '7D', '7H', '7S',
  '8C', '8D', '8H', '8S',
  '9C', '9D', '9H', '9S',
  '10C', '10D', '10H', '10S',
  'JC', 'JD', 'JH', 'JS',
  'QC', 'QD', 'QH', 'QS',
  'KC', 'KD', 'KH', 'KS',
  'AC', 'AD', 'AH', 'AS'
];


List<int> cardIndices = [ 0, 0, 0, 0, 0];
String thisPokerHand = 'Nothing Yet...';

// void newHand() {
//   List<int> drawnCards = [];
//   int cardIndex = -1;
//   for (int i = 0; i < cardIndices.length; i++) {
//     do {
//       cardIndex = Random().nextInt(52);
//     } while (drawnCards.contains(cardIndex));
//     drawnCards.add(cardIndex);
//   }
//   drawnCards.sort();
//   cardIndices = drawnCards;
//
//   // test area
//   // straight flush
//   // cardIndices = [ 0, 4, 8, 12, 16 ];
//
//   // royal flush
//   // cardIndices = [ 32, 36, 40, 44, 48 ];
//   // test area
//
//
//   List<int> cardRanks = cardIndices.map((e) => e~/4 + 2).toList();
//   List<int> cardSuits = cardIndices.map((e) => e%4).toList();
//   // print('cardRanks: $cardRanks');
//   // print('cardSuits: $cardSuits');
//
//   thisPokerHand = updatePokerHandLabel(cardIndices, cardRanks, cardSuits);
//
// }

String updatePokerHandLabel(List<int> cardIndices, List<int> cardRanks, List<int> cardSuits) {
  if (hasAnyFlush(cardIndices)) {
    if (cardRanks[0] == 10 &&
        cardRanks[1] == 11 &&
        cardRanks[2] == 12 &&
        cardRanks[3] == 13 &&
        cardRanks[4] == 14) {
      return 'ROYAL FLUSH';
    }
    else if (cardRanks[0] + 1 == cardRanks[1] &&
        cardRanks[1] + 1 == cardRanks[2] &&
        cardRanks[2] + 1 == cardRanks[3] &&
        cardRanks[3] + 1 == cardRanks[4]) {
      return 'STRAIGHT FLUSH';
    }
    else return 'FLUSH!';
  }
  if (hasAnyPair(cardIndices)) return 'PAIR!';
  return 'High Card';
}

bool hasAnyFlush(List<int> hand) {
  List<int> cardSuits = hand.map((e) => e%4).toList();
  var suitOccurences = Map();
  cardSuits.forEach((card) {
    if (!suitOccurences.containsKey(card)) suitOccurences[card] = 1;
    else suitOccurences[card] += 1;
  });
  return suitOccurences.containsValue(5);
}

bool hasAnyPair(List<int> hand) {
  var rankCounts = Map();
  hand.map((e) => e~/4).forEach((card) {
    if (!rankCounts.containsKey(card)) rankCounts[card] = 1;
    else rankCounts[card] += 1;
  });
  var counts = rankCounts.values.toList();
  counts.sort();
  if (counts.last > 1) return true;
  return false;
}