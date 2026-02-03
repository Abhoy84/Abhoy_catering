class MenuItem {
  String id;
  String nameEn;
  String nameBn;
  String nameHi;
  double price;
  String type; // Starter, Main Course, etc.
  String category; // VEG, NON-VEG
  String imageUrl;
  bool isAvailable;
  String description;
  String quantity;
  String unit;

  MenuItem({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    required this.nameHi,
    required this.price,
    required this.type,
    required this.category,
    required this.imageUrl,
    this.isAvailable = true,
    this.description = '',
    this.quantity = '',
    this.unit = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'nameEn': nameEn,
      'nameBn': nameBn,
      'nameHi': nameHi,
      'price': price,
      'type': type,
      'category': category,
      'imageUrl': imageUrl,
      'isAvailable': isAvailable,
      'description': description,
      'quantity': quantity,
      'unit': unit,
    };
  }

  factory MenuItem.fromMap(String id, Map<String, dynamic> map) {
    return MenuItem(
      id: id,
      nameEn: map['nameEn'] ?? '',
      nameBn: map['nameBn'] ?? '',
      nameHi: map['nameHi'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      type: map['type'] ?? '',
      category: map['category'] ?? 'VEG',
      imageUrl: map['imageUrl'] ?? '',
      isAvailable: map['isAvailable'] ?? true,
      description: map['description'] ?? '',
      quantity: map['quantity'] ?? '',
      unit: map['unit'] ?? '',
    );
  }
}
