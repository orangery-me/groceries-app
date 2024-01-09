import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/model/grocery_item.dart';
import 'package:shopping_app/presentation/newItem/new_item.dart';
import 'bloc/grocery_bloc.dart';

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
    return BlocBuilder<GroceryBloc, GroceryState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Your Groceries'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                                value: context.read<GroceryBloc>(),
                                child: const NewItem(),
                              )))
                      .then((value) =>
                          context.read<GroceryBloc>().add(GetGroceries()));
                },
                icon: const Icon(Icons.add),
              )
            ],
          ),
          body: Builder(
            builder: (context) {
              final groceryItems = context.watch<GroceryBloc>().state.items;
              return Column(
                children: [
                  ...groceryItems
                      .map((value) => GroceryItemWidget(groceryItem: value))
                      .toList()
                ],
              );
            },
          ),
        );
      },
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
