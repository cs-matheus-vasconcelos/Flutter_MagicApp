class Card {
  String name;
  String imageURL;

  Card.fromJSON(Map<String, dynamic> json) : 
  name = json["name"], 
  imageURL = json["imageUrl"];
}

class Deck {
  List<Card> cards;
  
  Deck.fromJSON(Map<String, dynamic> json) {
    final jsonCards = json["cards"] as List;
    cards = jsonCards.map((jsonCard) => Card.fromJSON(jsonCard)).toList();
  }
   
}