import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CardView extends StatelessWidget {

  final String _cardURL;

  CardView(this._cardURL);

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget>[
            Center(child: CircularProgressIndicator()),
            Center(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: _cardURL,
              ),
            ),
          ],
        );
  }
}