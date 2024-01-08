import 'package:bloc/bloc.dart';
import 'package:shopping_app/model/grocery_item.dart';

part 'grocery_event.dart';
part 'grocery_state.dart';

class GroceryBloc extends Bloc<GroceryEvent, GroceryState> {
  GroceryBloc() : super(const GroceryState()) {
    on<AddGroceryItem>(_addGroceryItem);
  }

  void _addGroceryItem(AddGroceryItem event, Emitter<GroceryState> emit) {
    emit(state.copyWith(
        items: [...state.items, event.selectedItem], number: state.number + 1));
  }
}
