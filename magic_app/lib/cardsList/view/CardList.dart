import 'package:flutter/material.dart';
import 'package:magic_app/cardsList/viewModel/CardListViewModel.dart';
import 'package:magic_app/cardsList/model/Card.dart' as magic;
import 'package:magic_app/components/CardView.dart';
import 'package:magic_app/network/NetworkResponse.dart';
import 'package:provider/provider.dart';

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

  Widget buildBody() {
    final viewModel = Provider.of<CardListViewModel>(context);
    switch (viewModel.responseController.status) {
      case Status.LOADING:
        return Center(child: CircularProgressIndicator());
      
      case Status.ERROR:
        return Center(child: Text(viewModel.responseController.message));

      case Status.COMPLETED:
        return cardsList();

      default:
        // viewModel.fetchCards();
        return Center(child: TextButton(child: Text("Request"), onPressed: () {
          viewModel.fetchCards();
        },));
    }
  }

  GridView cardsList() {
    return GridView.count(
    restorationId: 'grid_view_card_list',
    crossAxisCount: 2,
    mainAxisSpacing: 8,
    crossAxisSpacing: 8,
    padding: const EdgeInsets.all(8),
    childAspectRatio: 63/88,
    children: cards(),
    );
  }

  List<CardView> cards() {
    final viewModel = Provider.of<CardListViewModel>(context);
    final List<magic.Card> cards = viewModel.responseController.data;
    return cards.map((card) => CardView(card)).toList();
  }

}
