import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/data/categories.dart';
import 'package:shopping_app/model/category.dart';
import 'package:shopping_app/model/grocery_item.dart';
import 'package:shopping_app/presentation/grocery/bloc/grocery_bloc.dart';
import 'package:http/http.dart' as http;

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  // GlobalKey helps to keep the internal state attach to its widget
  // => tell Flutter when to show error
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables]!;

  void onAddNewItemButtonPressed() async {
    final url = Uri.https(
        'flutter-prep-41f1f-default-rtdb.firebaseio.com', 'shopping-list.json');
    // validate is a method in Form(), which get the state of key and execute the validate
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            // id would be generated automatically
            'name': _enteredName,
            'quantity': _enteredQuantity,
            'category': _selectedCategory.name
          }));

      print(response.body);
      print(response.statusCode);

      // final newItem = GroceryItem(
      //     id: DateTime.now().toString(),
      //     name: _enteredName,
      //     quantity: _enteredQuantity,
      //     category: _selectedCategory);

      if (!context.mounted) return;

      // context.read<GroceryBloc>().add(AddGroceryItem(selectedItem: newItem));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Item'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                    maxLength: 30,
                    autocorrect: false,
                    decoration: const InputDecoration(label: Text('Name')),
                    validator: (input) {
                      if (input == null ||
                          input.isEmpty ||
                          input.trim().length <= 1 ||
                          input.trim().length > 50) {
                        return 'Name must be between 2 to 50 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredName = value!;
                    }),
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Expanded(
                    child: TextFormField(
                      autocorrect: false,
                      decoration:
                          const InputDecoration(label: Text('Quantity')),
                      initialValue: _enteredQuantity.toString(),
                      validator: (input) {
                        if (input == null ||
                            input.isEmpty ||
                            int.tryParse(input.trim()) ==
                                null || // get null when type in not-int input
                            int.parse(input.trim()) <= 0) {
                          return 'Quantity must be a valid positive number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredQuantity = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                        value: _selectedCategory,
                        items: [
                          for (final category in categories.entries)
                            DropdownMenuItem(
                              value: category.value,
                              child: Row(
                                children: [
                                  Container(
                                      height: 16,
                                      width: 16.0,
                                      color: category.value.color),
                                  const SizedBox(width: 8),
                                  Text(category.value.name)
                                ],
                              ),
                            ),
                        ],
                        decoration:
                            const InputDecoration(label: Text('Category:')),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        }),
                  )
                ]),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: onAddNewItemButtonPressed,
                    child: const Text('Okay'))
              ],
            ),
          )),
    );
  }
}
