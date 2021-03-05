import 'package:flutter/material.dart';
import 'package:magic_app/cardsList/model/Card.dart' as magic;
import 'package:magic_app/cardsList/service/CardsService.dart';
import 'package:magic_app/network/NetworkResponse.dart';

class CardListViewModel extends ChangeNotifier {

  Response responseController;
  CardService _service;

  CardListViewModel([this._service]) {
    _service = _service ?? CardService();
    responseController = Response.none();
  }

  Future<void> fetchCards() async {
    setResponse(Response.loading("Loading Cards"));
    try {
      List<magic.Card> cards = await _service.fetchCards();
      setResponse(Response.completed(cards));
    } catch (e) {
      setResponse(Response.error(e.toString()));
    }
  }

  void setResponse(Response res) {
    responseController = res;
    notifyListeners();
  }

}