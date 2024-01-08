import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/model/grocery_item.dart';
import 'package:shopping_app/presentation/newItem/new_item.dart';
import 'bloc/grocery_bloc.dart';
import 'package:http/http.dart' as http;

class GroceriesView extends StatelessWidget {
  const GroceriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroceryBloc(),
      child: const GroceriesScreen(),
    );
  }
}

class GroceriesScreen extends StatelessWidget {
  const GroceriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<GroceryBloc, GroceryState>(
          buildWhen: (previous, current) => previous.number != current.number,
          builder: (context, state) {
            log('title change');
            return Text('Your Groceries ${state.number}');
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                        value: context.read<GroceryBloc>(),
                        child: const NewItem(),
                      )));
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Builder(builder: (context) {
        // final groceryItems = context.watch<GroceryBloc>().state.items;
        // final groceryItems =
        // context.select((GroceryBloc bloc) => bloc.state.items);
        final url = Uri.https('flutter-prep-41f1f-default-rtdb.firebaseio.com',
            'shopping-list.json');

        final groceryItems = http.get(url);

        return Column(
          children: [
            ...groceryItems
                .map((value) => GroceryItemWidget(groceryItem: value))
                .toList()
          ],
        );
      }),
    );
  }
}

class GroceryItemWidget extends StatelessWidget {
  final GroceryItem groceryItem;
  const GroceryItemWidget({required this.groceryItem, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            color: groceryItem.category.color,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(child: Text(groceryItem.name)),
          Text('${groceryItem.quantity}'),
        ],
      ),
    );
  }
}
