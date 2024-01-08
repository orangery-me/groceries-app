// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shopping_app/model/category.dart';

class GroceryItem {
  final String name;
  final int quantity;
  final Category category;

  const GroceryItem({
    required this.name,
    required this.quantity,
    required this.category,
  });

  @override
  String toString() {
    return 'GroceryItem{name: $name, quantity: $quantity, category: $category}';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'quantity': quantity,
      'category': category.toMap(),
    };
  }

  factory GroceryItem.fromMap(Map<String, dynamic> map) {
    return GroceryItem(
      name: map['name'] as String,
      quantity: map['quantity'] as int,
      category: Category.fromMap(map['category'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory GroceryItem.fromJson(String source) =>
      GroceryItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
