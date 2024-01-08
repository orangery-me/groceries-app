import 'dart:convert';
import 'package:shopping_app/constant.dart';
import 'package:shopping_app/model/grocery_item.dart';
import 'package:http/http.dart' as http;

class GroceryService {
  final url = Uri.https(Constant.url, 'shopping-list.json');

  Future<List<GroceryItem>> getGroceries() async {
    final response = await http.get(url);
    if (response.statusCode != 200) throw Exception('Can not get data');
    final Map<String, Map<String, dynamic>> decodedGrocery =
        jsonDecode(response.body);
    final List<GroceryItem> groceries = [];
    for (final item in decodedGrocery.entries) {
      groceries.add(GroceryItem.fromMap(item.value));
    }
    return groceries;
  }
}
