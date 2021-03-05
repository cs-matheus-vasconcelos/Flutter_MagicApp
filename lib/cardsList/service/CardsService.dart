import 'package:magic_app/cardsList/model/Card.dart';
import 'package:magic_app/network/APIProvider.dart';

class CardService {

  APIProvider _client;

  CardService([this._client]) {
    _client = _client ?? APIProvider();
  }

  Future<List<Card>> fetchCards() async {
    final response = await _client.get("/cards");
    return Deck.fromJSON(response).cards;
  }

}