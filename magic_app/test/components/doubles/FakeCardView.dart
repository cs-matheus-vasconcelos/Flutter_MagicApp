import 'package:flutter/material.dart';
import 'package:magic_app/components/CardView.dart';
import 'package:magic_app/cardsList/model/Card.dart' as magic;

class FakeCardView extends CardView {

  FakeCardView(magic.Card card) : super(card);

  @override
  Widget networkImage() => Image(image: AssetImage("assets/magicBackground.png"));

}