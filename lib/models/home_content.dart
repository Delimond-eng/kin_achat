class HomeContent {
  Reponse reponse;

  HomeContent({this.reponse});

  HomeContent.fromJson(Map<String, dynamic> json) {
    reponse =
        json['reponse'] != null ? Reponse.fromJson(json['reponse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reponse != null) {
      data['reponse'] = reponse.toJson();
    }
    return data;
  }
}

class Reponse {
  List<Produit> recommendations;
  List<Produit> produits;
  List<Categorie> categories;

  Reponse({this.recommendations, this.produits, this.categories});

  Reponse.fromJson(Map<String, dynamic> json) {
    if (json['recommendations'] != null) {
      recommendations = <Produit>[];
      json['recommendations'].forEach((v) {
        recommendations.add(Produit.fromJson(v));
      });
    }
    if (json['produits'] != null) {
      produits = <Produit>[];
      json['produits'].forEach((v) {
        produits.add(Produit.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categorie>[];
      json['categories'].forEach((v) {
        categories.add(Categorie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (recommendations != null) {
      data['recommendations'] = recommendations.map((v) => v.toJson()).toList();
    }
    if (produits != null) {
      data['produits'] = produits.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      data['categories'] = categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categorie {
  String produitCategorieId;
  String icon;
  String categorie;
  String produitCategorieStatus;
  String dateEnregistrement;

  Categorie({
    this.produitCategorieId,
    this.icon,
    this.categorie,
    this.produitCategorieStatus,
    this.dateEnregistrement,
  });

  Categorie.fromJson(Map<String, dynamic> json) {
    produitCategorieId = json['produit_categorie_id'];
    icon = json['icon'];
    categorie = json['categorie'];
    produitCategorieStatus = json['produit_categorie_status'];
    dateEnregistrement = json['date_enregistrement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['produit_categorie_id'] = produitCategorieId;
    data['icon'] = icon;
    data['categorie'] = categorie;
    data['produit_categorie_status'] = produitCategorieStatus;
    data['date_enregistrement'] = dateEnregistrement;
    return data;
  }
}

class Produit {
  String produitId;
  String titre;
  String prix;
  String devise;
  String description;
  String image;

  Produit({
    this.produitId,
    this.titre,
    this.prix,
    this.devise,
    this.description,
    this.image,
  });

  Produit.fromJson(Map<String, dynamic> json) {
    produitId = json['produit_id'];
    titre = json['titre'];
    prix = json['prix'];
    devise = json['devise'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['produit_id'] = produitId;
    data['titre'] = titre;
    data['prix'] = prix;
    data['devise'] = devise;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}
