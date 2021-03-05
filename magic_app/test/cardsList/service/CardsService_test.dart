import 'package:flutter_test/flutter_test.dart';
import 'package:magic_app/cardsList/service/CardsService.dart';
import 'package:magic_app/network/NetworkError.dart';
import 'package:mockito/mockito.dart';
import 'dart:convert';
import '../../Helpers/Constants/Constants.dart';
import '../../Helpers/Mocks/MockAPIProvider.dart';

void main() {

  group("CardService -", () {

    test("fetch cards success", () async {
      final mockProvider = MockAPIProvider();
      when(mockProvider.get("/cards"))
      .thenAnswer((_) async => json.decode('{"cards": [{"name": "A card", "imageUrl": "$testBaseURL"}]}'));

      final sut = CardService(mockProvider);

      final deck = await sut.fetchCards();

      expect(deck.length, 1);
    });

    test("fetch cards failure", () async {
      final mockProvider = MockAPIProvider();
      when(mockProvider.get("/cards")).thenThrow(AuthenticationRequiredException("Auth error"));

      final sut = CardService(mockProvider);

      expect(sut.fetchCards(), throwsA(isA<AuthenticationRequiredException>()));
    });

  });

}