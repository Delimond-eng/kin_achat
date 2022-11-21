import 'package:kinachat/models/home_content.dart';

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
}
