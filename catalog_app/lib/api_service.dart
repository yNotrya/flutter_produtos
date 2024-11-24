import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product.dart';

// Função para buscar os produtos da API
Future<List<Product>> fetchProducts() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

  if (response.statusCode == 200) {
    // Se a requisição for bem-sucedida, converta o JSON para uma lista de objetos Product
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Product.fromJson(json)).toList();
  } else {
    // Se a requisição falhar, lança um erro
    throw Exception('Falha ao carregar produtos');
  }
}
