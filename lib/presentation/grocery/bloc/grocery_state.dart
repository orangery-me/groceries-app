part of 'grocery_bloc.dart';

class GroceryState {
  final List<GroceryItem> items;
  const GroceryState({
    this.items = const <GroceryItem>[],
  });
  GroceryState addGroceryItem(GroceryItem groceryItem) {
    return GroceryState(items: [...items, groceryItem]);
  }
}
