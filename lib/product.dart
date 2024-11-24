class Product {
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Product({
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  // Converte o JSON para o objeto Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}
