import 'package:kinachat/models/home_content.dart';
import 'package:kinachat/utils/utils.dart';

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
    gPrint(categoryId);
    var datas = await Api.request(
      method: "post",
      url: "/content/categorie",
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
