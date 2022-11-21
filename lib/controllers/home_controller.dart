import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:kinachat/api/repositories/public_repo.dart';
import 'package:kinachat/models/home_content.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();

  //*variables*//

  var produits = <Produit>[].obs;
  var recommandations = <Produit>[].obs;
  var categorieProduits = <Produit>[].obs;
  var categories = <Categorie>[].obs;
  var isHomeLoading = false.obs;

  //*end variables*//

  //*connection*//
  StreamSubscription<ConnectivityResult> connectivitySubscription;
  final Connectivity connectivity = Connectivity();

  @override
  void onInit() {
    refreshHomeContent();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        refreshHomeContent();
      }
    });
    super.onInit();
  }

  void refreshHomeContent() async {
    isHomeLoading.value = true;
    PublicRepo.getHomeContent().then((contents) {
      isHomeLoading.value = false;
      if (contents != null) {
        produits.addAll(contents.reponse.produits);
        recommandations.addAll(contents.reponse.recommendations);
        categories.addAll(contents.reponse.categories);
      }
    });
  }
}
