import 'package:kinachat/models/home_content.dart';

import '../../models/category_produits.dart';
import '../index.dart';

class PublicRepo {
  static Future<HomeContent> getHomeContent() async {
    var contents = await Api.request(
      method: "get",
      url: "/content/home",
    );

    if (contents != null) {
      return HomeContent.fromJson(contents);
    }
    return null;
  }

  static Future<CategorieProduits> getSelectedCategoriesProducts(
      categoryId) async {
    var datas = await Api.request(
      method: "post",
      body: {
        "produit_categorie_id": categoryId,
      },
    );
    if (datas != null) {
      return CategorieProduits.fromJson(datas);
    }
    return null;
  }
}
