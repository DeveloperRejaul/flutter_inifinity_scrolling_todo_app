import 'dart:convert';

class ProductModel {
  int? id;
  String? title;
  int? price;
  String? thumbnail;
  ProductModel({this.id, this.title, this.price, this.thumbnail});

  ProductModel copyWith({
    int? id,
    String? title,
    int? price,
    String? thumbnail,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    if (price != null) {
      result.addAll({'price': price});
    }
    if (thumbnail != null) {
      result.addAll({'thumbnail': thumbnail});
    }

    return result;
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id']?.toInt(),
      title: map['title'],
      price: map['price']?.toInt(),
      thumbnail: map['thumbnail'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, price: $price, thumbnail: $thumbnail)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.id == id &&
        other.title == title &&
        other.price == price &&
        other.thumbnail == thumbnail;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ price.hashCode ^ thumbnail.hashCode;
  }
}
