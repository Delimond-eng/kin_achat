import 'package:kinachat/utils/utils.dart';
import 'db.dart';

class Repo {
  static void insertFavorite() async {
    var db = await DB.initDb();
    var lastedInserted = await db.insert("favorites", {});
    gPrint(lastedInserted);
    //TODO: implement
  }
}
