part of 'grocery_bloc.dart';

class GroceryEvent {}

class AddGroceryItem extends GroceryEvent {
  final GroceryItem selectedItem;
  AddGroceryItem({required this.selectedItem});
}
