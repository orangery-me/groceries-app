import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:shopping_app/data/grocery_service.dart';
import 'package:shopping_app/model/grocery_item.dart';

part 'grocery_event.dart';
part 'grocery_state.dart';

class GroceryBloc extends Bloc<GroceryEvent, GroceryState> {
  GroceryBloc() : super(const GroceryState()) {
    on<GetGroceries>(_getGroceries);
    on<PostGrocery>(_postGrocery);
    add(GetGroceries());
  }

  Future<void> _getGroceries(
      GetGroceries event, Emitter<GroceryState> emit) async {
    try {
      final groceries = await GroceryService().getGroceries();
      emit(state.copyWith(items: groceries, number: state.number));
    } catch (e) {
      log(e.toString());
      return;
    }
  }

  // Future<void> _postGrocery

  Future<void> _postGrocery(
      PostGrocery event, Emitter<GroceryState> emit) async {
    try {
      await GroceryService().postGrocery(event.newItem);
    } catch (e) {
      log(e.toString());
      return;
    }
  }
}
