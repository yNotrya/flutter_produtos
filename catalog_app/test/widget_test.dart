import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catalog_app/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Mock da resposta da API
class MockHttpClient extends Mock implements http.Client {
  @override
  Future<http.Response> get(Uri url) {
    return Future.value(http.Response(
      jsonEncode([
        {
          'id': 1,
          'title': 'Camiseta',
          'price': 49.99,
          'description': 'Camiseta confortável e estilosa',
          'image': 'https://example.com/camiseta.jpg',
        },
        {
          'id': 2,
          'title': 'Notebook',
          'price': 2499.99,
          'description': 'Notebook potente para suas tarefas',
          'image': 'https://example.com/notebook.jpg',
        },
      ]),
      200,
    ));
  }
}

void main() {
  testWidgets('Verifica se os produtos são carregados corretamente', (WidgetTester tester) async {
    // Substituir o cliente HTTP para usar o mock
    final client = MockHttpClient();

    // Inicializa o app com o mock do client
    await tester.pumpWidget(MyApp(client: client));

    // Verifica se a lista de produtos é exibida
    expect(find.text('Camiseta'), findsOneWidget);  // Título do produto 1
    expect(find.text('Notebook'), findsOneWidget);  // Título do produto 2
    expect(find.text('R\$ 49.99'), findsOneWidget);  // Preço do produto 1
    expect(find.text('R\$ 2499.99'), findsOneWidget);  // Preço do produto 2

    // Verifica se a imagem está sendo carregada (usando o URL da imagem)
    expect(find.byType(Image), findsNWidgets(2)); // Deve haver 2 imagens
  });
}
