class Book {
  final String title;
  final String author;
  final String publisher;
  final int stock;
  final String imageUrl;

  Book({
    required this.title,
    required this.author,
    required this.publisher,
    required this.stock,
    required this.imageUrl,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Book &&
        other.title == title &&
        other.author == author &&
        other.publisher == publisher &&
        other.stock == stock &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        author.hashCode ^
        publisher.hashCode ^
        stock.hashCode ^
        imageUrl.hashCode;
  }
}
