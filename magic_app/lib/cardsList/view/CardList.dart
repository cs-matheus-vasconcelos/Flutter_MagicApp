import 'package:flutter/material.dart';
import 'package:magic_app/components/CardView.dart';

class CardList extends StatefulWidget {
  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Card List"),), 
      body: buildBody(),
      );
  }

  GridView buildBody() {
    return GridView.count(
      restorationId: 'grid_view_card_list',
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.all(8),
      childAspectRatio: 1,
      children: [
        CardView('https://picsum.photos/250?image=1'), 
        CardView('https://picsum.photos/250?image=2'), 
        CardView('https://picsum.photos/250?image=3'), 
        CardView('https://picsum.photos/250?image=4')],
    );
  }

}
