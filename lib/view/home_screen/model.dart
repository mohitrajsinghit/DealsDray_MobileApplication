class BannerModel {
  final String banner;

  BannerModel({required this.banner});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(banner: json['banner']);
  }

  @override
  String toString() {
    return 'BannerModel(banner: $banner)';
  }
}

class CategoryModel {
  final String label;
  final String icon;

  CategoryModel({required this.label, required this.icon});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      label: json['label'],
      icon: json['icon'],
    );
  }

  @override
  String toString() {
    return 'CategoryModel(label: $label, icon: $icon)';
  }
}


class ProductModel {
  final String icon;
  final String offer;
  final String label;
  final String subLabel;

  ProductModel({
    required this.icon,
    required this.offer,
    required this.label,
    required this.subLabel,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      icon: json['icon'],
      offer: json['offer'],
      label: json['label'],
      subLabel: json['SubLabel'] ?? json['Sublabel'],
    );
  }

  @override
  String toString() {
    return 'ProductModel(icon: $icon, offer: $offer, label: $label, subLabel: $subLabel)';
  }
}