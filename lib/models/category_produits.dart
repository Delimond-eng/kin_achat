import 'home_content.dart';

class CategorieProduits {
  Content content;

  CategorieProduits({this.content});

  CategorieProduits.fromJson(Map<String, dynamic> json) {
    content =
        json['content'] != null ? Content.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content.toJson();
    }
    return data;
  }
}

class Content {
  List<Produit> produits;

  Content({this.produits});

  Content.fromJson(Map<String, dynamic> json) {
    if (json['produits'] != null) {
      produits = <Produit>[];
      json['produits'].forEach((v) {
        produits.add(Produit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (produits != null) {
      data['produits'] = produits.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
