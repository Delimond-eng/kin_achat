class Product {
  int id;
  String title, price, imgPath;
  int qty;

  Product({this.id, this.title, this.price, this.imgPath});
}

List<Product> products = [
  Product(
      id: 1,
      title: "T-short man maroon",
      price: "7500",
      imgPath: "assets/images/img-1.png"),
  Product(
      id: 2,
      title: "JBL casque BTH",
      price: "25000",
      imgPath: "assets/images/img-7.png"),
  Product(
      id: 3,
      title: "Cagoule",
      price: "6500",
      imgPath: "assets/images/img-4.png"),
  Product(
    id: 4,
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
