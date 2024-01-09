part of 'grocery_bloc.dart';

class GroceryEvent {}

class GetGroceries extends GroceryEvent {}

class PostGrocery extends GroceryEvent {
  final GroceryItem newItem;
  PostGrocery({required this.newItem});
}
