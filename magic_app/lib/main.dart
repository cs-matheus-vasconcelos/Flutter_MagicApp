import 'package:flutter/material.dart';
import 'package:magic_app/cardsList/viewModel/CardListViewModel.dart';
import 'package:provider/provider.dart';
import 'cardsList/view/CardList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        create: (context) => CardListViewModel(), 
        child: CardList(),
        ),
    );
  }
}
