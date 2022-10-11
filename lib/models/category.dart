class Category {
  String title, iconPath;

  Category({this.title, this.iconPath});
}

List<Category> categories = [
  Category(iconPath: "assets/svgs/clothes.svg", title: "Vêtement"),
  Category(iconPath: "assets/svgs/mobile.svg", title: "Mobile & tablette"),
  Category(iconPath: "assets/svgs/beauty.svg", title: "Beauté"),
  Category(iconPath: "assets/svgs/resto.svg", title: "Restaurant"),
  Category(iconPath: "assets/svgs/job.svg", title: "Emploi"),
  Category(iconPath: "assets/svgs/electro.svg", title: "Electronique"),
];
