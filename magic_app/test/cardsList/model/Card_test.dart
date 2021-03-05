import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_app/cardsList/model/Card.dart';
import '../../Helpers/Constants/Constants.dart';

void main() {

  group("Card -", () {
    test("init from JSON", () {
      final card = Card.fromJSON(json.decode('{"name": "A card", "imageUrl": "$testBaseURL"}'));
      expect(card.name, "A card");
      expect(card.imageURL, testBaseURL);
    });
  });

  group("Deck -", () {
    test("init from JSON", () {
      final deck = Deck.fromJSON(json.decode('{"cards": [{"name": "A card", "imageUrl": "$testBaseURL"}]}'));

      expect(deck.cards.length, 1);
    });
  });

}