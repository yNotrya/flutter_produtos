import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Produtos',
      theme: ThemeData(
        primaryColor: Colors.blueAccent, // Cor da AppBar
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black), // Estilo de corpo 1
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black54), // Estilo de corpo 2
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Título da AppBar
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent, // Cor dos botões
        ),
      ),
      home: ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      setState(() {
        // Parse dos produtos e traduzir as descrições e títulos para português
        products = json.decode(response.body).map((product) {
          return {
            'id': product['id'],
            'title': translateTitle(product['title']),
            'price': product['price'],
            'description': translateDescription(product['description']),
            'image': product['image'],
          };
        }).toList();
      });
    } else {
      throw Exception('Falha ao carregar os produtos');
    }
  }

  // Função de tradução para o título
  String translateTitle(String title) {
    switch (title.toLowerCase()) {
      case 'men\'s clothing':
        return 'Roupas Masculinas';
      case 'women\'s clothing':
        return 'Roupas Femininas';
      case 'jewelery':
        return 'Joias';
      case 'electronics':
        return 'Eletrônicos';
      default:
        return title;
    }
  }

  // Função de tradução para a descrição
  String translateDescription(String description) {
    // Apenas exemplo de tradução simples. Pode-se expandir para mais traduções.
    if (description.contains('quality')) {
      return description.replaceFirst('quality', 'qualidade');
    }
    return description; // Se não houver tradução, retorna o texto original
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de Produtos'),
      ),
      body: Column(
        children: [
          // Header Moderno e Centralizado com Padding no topo
          Container(
            padding: EdgeInsets.only(top: 10.0), // Padding de 10px no topo
            width: double.infinity, // Faz o container ocupar toda a largura
            height: 250, // Definindo a altura do header
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.purpleAccent], // Gradiente de fundo
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),  // Padding para centralizar texto
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,  // Centraliza o conteúdo dentro do header
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Bem-vindo ao Catálogo de Produtos!',
                    style: TextStyle(
                      fontSize: 32,  // Aumentado o tamanho do título
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),  // Ajuste no espaçamento
                  Text(
                    'Explore uma variedade de produtos e descubra o que temos a oferecer.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),  // Mais espaço antes do botão
                  ElevatedButton(
                    onPressed: () {
                      // Exemplo de ação para o botão
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Explorando Catálogo!')),
                      );
                    },
                    child: Text('Ver Produtos', style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,  // Substitui 'primary' por 'backgroundColor'
                      foregroundColor: Colors.blueAccent,  // Substitui 'onPrimary' por 'foregroundColor'
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),  // Ajustado o padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),  // Arredondado mais o botão
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),  // Mais espaço após o header
          // Lista de produtos
          Expanded(  // Garante que a lista ocupe o restante da tela
            child: products.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: products.length > 10 ? 10 : products.length, // Limitando a 10 itens
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Card(
                        margin: EdgeInsets.all(8),
                        elevation: 5,
                        child: ListTile(
                          leading: ClipRRect(  // Melhorando a imagem
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              product['image'],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(product['title']),
                          subtitle: Text('Preço: R\$ ${product['price']}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(product: product),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final dynamic product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product['image']),
            SizedBox(height: 24),  // Mais espaço entre a imagem e o título
            Text(
              product['title'],
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),  // Aumentado o tamanho do título
            ),
            SizedBox(height: 12),  // Espaço entre o título e o preço
            Text(
              'Preço: R\$ ${product['price']}',
              style: TextStyle(fontSize: 22, color: Colors.green),
            ),
            SizedBox(height: 24),  // Espaço entre preço e descrição
            Text(
              'Descrição:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              product['description'],
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
