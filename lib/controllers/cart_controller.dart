import 'dart:async';

import 'package:get/get.dart';
import 'package:kinachat/db/repository.dart';
import 'package:kinachat/models/home_content.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();

  var cartList = <Produit>[].obs;
  var cartTotal = 0.0.obs;

  @override
  void onInit() {
    initCartTotal();
    super.onInit();
  }

  /*Add item to cart*/
  Future<void> addItemToCart(Produit data) async {
    InternalRepo.addItemToDbCart(data).then((cart) {
      initCartTotal();
    });
  }

  /*Remove item from cart*/
  Future<void> removeItemTocart(Produit data) async {
    InternalRepo.removeItemToDbCart(data).then((cart) {
      initCartTotal();
    });
  }

  /*Stream init total amount*/
  Future<void> initCartTotal() async {
    await refreshData().then((_) {
      var totalCount = streamCounter();
      totalCount.listen((updatedTotal) {
        cartTotal.value = updatedTotal ?? 0.0;
      });
    });
  }

  Future<void> refreshData() async {
    var dbCart = await InternalRepo.getDbCart();
    cartList.clear();
    cartList.addAll(dbCart);
  }

  Stream<double> streamCounter() async* {
    double total = 0;
    var controller = StreamController<double>();
    Future.delayed(const Duration(milliseconds: 500), () {
      for (var el in cartList) {
        double t = (double.parse(el.prix) * el.defaultQty).toDouble();
        total += t;
      }
      controller.add(total);
    });
    yield* controller.stream;
  }

  Future<void> removeAll() async {
    cartList.clear();
    cartTotal.value = 0.0;
  }
}
