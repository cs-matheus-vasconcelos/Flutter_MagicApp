import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_app/cardsList/view/CardList.dart';
import 'package:magic_app/cardsList/viewModel/CardListViewModel.dart';
import 'package:magic_app/network/NetworkResponse.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import '../../Helpers/Utils.dart';

class MockCardListViewModel extends Mock implements CardListViewModel {}

void main() {
  group("CardList -", () {
    testWidgets("Loading state", (WidgetTester tester) async {
      MockCardListViewModel viewModel = MockCardListViewModel();
      Widget cardList = ChangeNotifierProvider<CardListViewModel>(
        create: (context) => viewModel,
        child: CardList(),
      );

      when(viewModel.responseController)
          .thenReturn(Response.loading("loading"));

      await tester.pumpWidget(makeTestable(cardList));

      final progress = find.byType(CircularProgressIndicator);

      expect(progress, findsOneWidget);
    });

    testWidgets("Error state", (WidgetTester tester) async {
      MockCardListViewModel viewModel = MockCardListViewModel();
      Widget cardList = ChangeNotifierProvider<CardListViewModel>(
        create: (context) => viewModel,
        child: CardList(),
      );

      when(viewModel.responseController).thenReturn(Response.error("Error"));

      await tester.pumpWidget(makeTestable(cardList));

      final textValue = find.text("Error");

      expect(textValue, findsOneWidget);
    });
  });
}
