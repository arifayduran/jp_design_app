class Item {
  const Item({
    required this.title,
    required this.subtitle,
    this.description,
    required this.price,
    required this.likedCount,
    required this.reviews,
    required this.isGluten,
    required this.isLowFat,
    required this.isKcal,
    required this.isSugar,
    this.assetPath,
  });

  final String title;
  final String subtitle;
  final String? description;
  final double price;
  final int likedCount;
  final double reviews;
  final bool isGluten;
  final bool isLowFat;
  final bool isKcal;
  final bool isSugar;
  final String? assetPath;
}
