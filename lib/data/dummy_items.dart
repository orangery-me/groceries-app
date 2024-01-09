import 'package:shopping_app/data/categories.dart';
import 'package:shopping_app/model/grocery_item.dart';
import 'package:shopping_app/model/category.dart';

var groceryItems = [
  GroceryItem(
      name: 'Milk', quantity: 1, category: categories[Categories.dairy]!),
  GroceryItem(
      name: 'Bananas', quantity: 5, category: categories[Categories.fruit]!),
  GroceryItem(
      name: 'Beef Steak', quantity: 1, category: categories[Categories.meat]!),
];
