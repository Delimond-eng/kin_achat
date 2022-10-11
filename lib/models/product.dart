class Product {
  String title, price, imgPath;

  Product({this.title, this.price, this.imgPath});
}

List<Product> products = [
  Product(
      title: "T-short man maroon",
      price: "7500",
      imgPath: "assets/images/img-1.png"),
  Product(
      title: "JBL casque BTH",
      price: "25000",
      imgPath: "assets/images/img-7.png"),
  Product(title: "Cagoule", price: "6500", imgPath: "assets/images/img-4.png"),
  Product(
    title: "T-short woman",
    price: "5590",
    imgPath: "assets/images/img-3.png",
  ),
  Product(
    title: "Oraimo casque BTH",
    price: "20000",
    imgPath: "assets/images/img-8.png",
  ),
];
