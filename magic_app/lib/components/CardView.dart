import 'package:flutter/material.dart';
import 'package:magic_app/cardsList/model/Card.dart' as magic;
import 'package:transparent_image/transparent_image.dart';

class CardView extends StatelessWidget {

  final magic.Card _card;

  CardView(this._card);

  @override
  Widget build(BuildContext context) {
    return _card.imageURL == null ? defaultImage() : cardImage();
  }

  Widget cardImage() {
    return Stack(
      children: <Widget>[
        Center(child: CircularProgressIndicator()),
        Center(child: networkImage()),
      ],
    );
  }

  Widget networkImage() {
    return FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: _card.imageURL,
        );
  }

  Widget defaultImage() {
    return Stack(
      children: [
        Center(child: Image(image: AssetImage("assets/magicBackground.png"))),
        Center(child: Text(_card.name, style: TextStyle(color: Colors.white),),)
      ],
    );
  }

}