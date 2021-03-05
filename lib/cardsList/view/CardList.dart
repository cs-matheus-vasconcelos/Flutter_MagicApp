import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

  CardListViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _viewModel.fetchCards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Card List"),), 
      body: buildBody(),
      );
  }

  Widget buildBody() {
    _viewModel = Provider.of<CardListViewModel>(context);
    switch (_viewModel.responseController.status) {
      case Status.LOADING:
        return Center(child: CircularProgressIndicator());
      
      case Status.ERROR:
        return Center(child: Text(_viewModel.responseController.message));

      case Status.COMPLETED:
        return cardsList();

      default:
        return Center(child: Text("initial"));
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
    final List<magic.Card> cards = _viewModel.responseController.data;
    return cards.map((card) => CardView(card)).toList();
  }

}
