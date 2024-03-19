class FoodCategory {
  String categoryName;
  String categoryImage;
  FoodCategory({
    required this.categoryName,
    required this.categoryImage,
  });
}

//Fixed Categories
var foodCategories = [
  FoodCategory(categoryName: 'Bread', categoryImage: 'assets/bread.png'),
  FoodCategory(categoryName: 'Cheese', categoryImage: 'assets/cheese.png'),
  FoodCategory(
      categoryName: 'Chicken', categoryImage: 'assets/chicken-leg.png'),
  FoodCategory(categoryName: 'Meat', categoryImage: 'assets/meat 2.png'),
  FoodCategory(categoryName: 'Fruits', categoryImage: 'assets/fruit.png'),
  FoodCategory(
      categoryName: 'Vegtebales', categoryImage: 'assets/vegetable 2.png'),
  FoodCategory(categoryName: 'Milk', categoryImage: 'assets/milk.png'),
];
