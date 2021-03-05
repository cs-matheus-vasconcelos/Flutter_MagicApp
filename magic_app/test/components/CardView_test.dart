import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_app/components/CardView.dart';
import 'package:magic_app/cardsList/model/Card.dart' as magic;
import '../Helpers/Constants/Constants.dart';
import '../Helpers/Utils.dart';
import 'doubles/FakeCardView.dart';

void main() {
  group("CardView -", () {
    testWidgets("Card View with no image URL", (WidgetTester tester) async {
      final card = magic.Card("A cool card", null);
      await tester.pumpWidget(makeTestable(CardView(card)));

      final cardName = find.text("A cool card");

      expect(cardName, findsOneWidget);
    });

    testWidgets("Card View with image URL", (WidgetTester tester) async {
      final card = magic.Card("A cool card", testBaseURL);

      await tester.pumpWidget(makeTestable(FakeCardView(card)));

      final cardName = find.text("A cool card");
      final progress = find.byType(CircularProgressIndicator);
      final image = find.byType(Image);

      expect(cardName, findsNothing);
      expect(progress, findsOneWidget);
      expect(image, findsOneWidget);
    });
  });
}