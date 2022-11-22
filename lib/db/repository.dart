import 'package:kinachat/utils/utils.dart';
import '../models/home_content.dart';
import 'db.dart';

class InternalRepo {
  static Future<String> insertFavorite(Produit data) async {
    var db = await DB.initDb();
    var p = await db
        .query("favorites", where: "produit_id=?", whereArgs: [data.produitId]);
    if (p.isEmpty) {
      var lastInserted = await db.insert("favorites", data.toJson());
      gPrint(lastInserted);
      return data.produitId;
    } else {
      var lastDeleted = await db.delete("favorites",
          where: "produit_id=?", whereArgs: [data.produitId]);
      gPrint(lastDeleted);
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
}
