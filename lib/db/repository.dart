import '../models/home_content.dart';
import 'db.dart';

class InternalRepo {
  static Future<String> insertFavorite(Produit data) async {
    var db = await DB.initDb();
    var p = await db
        .query("favorites", where: "produit_id=?", whereArgs: [data.produitId]);
    if (p.isEmpty) {
      await db.insert("favorites", data.toJson());
      return data.produitId;
    } else {
      await db.delete("favorites",
          where: "produit_id=?", whereArgs: [data.produitId]);

      return "";
    }
  }

  static Future<bool> getIsFavorite(Produit data) async {
    var db = await DB.initDb();
    var p = await db
        .query("favorites", where: "produit_id=?", whereArgs: [data.produitId]);
    if (p.isNotEmpty) {
      return true;
    }
    return false;
  }

  static Future<List<Produit>> getFavorites() async {
    var db = await DB.initDb();
    var favorites = <Produit>[];
    var s = await db.query("favorites");
    for (var data in s) {
      favorites.add(Produit.fromJson(data));
    }
    return favorites;
  }

  static Future<List<Produit>> addItemToDbCart(Produit data, {int q}) async {
    var db = await DB.initDb();
    var s = await db
        .query("carts", where: "produit_id=?", whereArgs: [data.produitId]);
    if (s.isEmpty) {
      db.insert("carts", data.toJson());
    } else {
      db.update("carts", {"qty": (q)});
    }
    var carts = await getDbCart();
    return carts;
  }

  static Future<List<Produit>> removeItemToDbCart(Produit data) async {
    var db = await DB.initDb();
    await db
        .delete("carts", where: "produit_id=?", whereArgs: [data.produitId]);
    var carts = await getDbCart();
    return carts;
  }

  static Future<List<Produit>> getDbCart() async {
    var db = await DB.initDb();
    var carts = <Produit>[];
    var jsonList = await db.query("carts");
    for (var d in jsonList) {
      carts.add(Produit.fromJson(d));
    }
    return carts;
  }
}
