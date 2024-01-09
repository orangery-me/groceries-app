import 'dart:convert';
import 'package:shopping_app/constant.dart';
import 'package:shopping_app/model/grocery_item.dart';
import 'package:http/http.dart' as http;

class GroceryService {
  final url = Uri.https(Constant.url, 'shopping-list.json');

  Future<List<GroceryItem>> getGroceries() async {
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception('Can not get data');
    }
    final decodedGrocery = jsonDecode(response.body);

    final groceries = <GroceryItem>[];
    for (final item in decodedGrocery.keys) {
      groceries.add(GroceryItem.fromMap(decodedGrocery[item]));
    }

    return groceries;
  }

  Future<void> postGrocery(GroceryItem item) async {
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: item.toJson());
    if (response.statusCode != 200) {
      throw Exception('There is an error. Please try again later');
    }
  }
}
