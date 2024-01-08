part of 'grocery_bloc.dart';

class GroceryState {
  final List<GroceryItem> items;
  final int number;
  const GroceryState({this.items = const <GroceryItem>[], this.number = 0});
  GroceryState copyWith({
    List<GroceryItem>? items,
    int? number,
  }) {
    return GroceryState(
        items: items ?? this.items, number: number ?? this.number);
  }
}
