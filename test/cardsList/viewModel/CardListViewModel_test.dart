import 'package:flutter_test/flutter_test.dart';
import 'package:magic_app/cardsList/service/CardsService.dart';
import 'package:magic_app/cardsList/viewModel/CardListViewModel.dart';
import 'package:magic_app/network/NetworkResponse.dart';
import 'package:magic_app/network/NetworkError.dart';
import 'package:magic_app/cardsList/model/Card.dart' as magic;
import 'package:mockito/mockito.dart';
import '../../Helpers/Constants/Constants.dart';

class MockCardService extends Mock implements CardService { }

void main() {

  group("CardListViewModel -", () {

    test("notify content state", () async {
      final mockService = MockCardService();
      final sut = CardListViewModel(mockService);
      final List<Response> states = [];
      sut.addListener(() {
        states.add(sut.responseController);
      });

      final List<magic.Card> deck = [magic.Card("A card", testBaseURL)];
      when(mockService.fetchCards()).thenAnswer((_) async => deck);

      await sut.fetchCards();

      expect(states.length, 2);
      expect(states[0].status, Status.LOADING);
      expect(states[1].status, Status.COMPLETED);
    });

    test("notify error state", () async {
      final mockService = MockCardService();
      final sut = CardListViewModel(mockService);
      final List<Response> states = [];
      sut.addListener(() {
        states.add(sut.responseController);
      });

      when(mockService.fetchCards()).thenThrow(AuthenticationRequiredException("Auth error"));

      await sut.fetchCards();

      expect(states.length, 2);
      expect(states[0].status, Status.LOADING);
      expect(states[1].status, Status.ERROR);
    });

  });

}