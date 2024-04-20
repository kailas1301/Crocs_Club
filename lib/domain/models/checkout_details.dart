class CheckoutData {
  final int cartId;
  final List<Address> addresses;
  final List<Product> products;
  final List<PaymentMethod> paymentMethods;

  CheckoutData({
    required this.cartId,
    required this.addresses,
    required this.products,
    required this.paymentMethods,
  });

  factory CheckoutData.fromJson(Map<String, dynamic> json) {
    final List<Address> parsedAddresses = List<Address>.from(
      json['Addresses'].map<Address>((address) => Address.fromJson(address)),
    );

    final List<Product> parsedProducts = List<Product>.from(
      json['Products'].map<Product>((product) => Product.fromJson(product)),
    );

    final List<PaymentMethod> parsedPaymentMethods = List<PaymentMethod>.from(
      json['PaymentMethod']
          .map<PaymentMethod>((method) => PaymentMethod.fromJson(method)),
    );

    return CheckoutData(
      cartId: json['CartID'] as int,
      addresses: parsedAddresses,
      products: parsedProducts,
      paymentMethods: parsedPaymentMethods,
    );
  }
}

class Address {
  final int id;
  final int userId;
  final String name;
  final String houseName;
  final String street;
  final String city;
  final String state;
  final String phone;
  final String pin;

  Address({
    required this.id,
    required this.userId,
    required this.name,
    required this.houseName,
    required this.street,
    required this.city,
    required this.state,
    required this.phone,
    required this.pin,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      name: json['name'] as String,
      houseName: json['house_name'] as String,
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      phone: json['phone'] as String,
      pin: json['pin'] as String,
    );
  }
}

class Product {
  final int productId;
  final String productName;
  final int categoryId;
  final int quantity;
  final int price;
  final int totalPrice;

  Product({
    required this.productId,
    required this.productName,
    required this.categoryId,
    required this.quantity,
    required this.price,
    required this.totalPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'] as int,
      productName: json['product_name'] as String,
      categoryId: json['category_id'] as int,
      quantity: json['quantity'] as int,
      price: json['price'] as int,
      totalPrice: json['total_price'] as int,
    );
  }
}

class PaymentMethod {
  final int id;
  final String paymentName;

  PaymentMethod({
    required this.id,
    required this.paymentName,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['ID'] as int,
      paymentName: json['payment_name'] as String,
    );
  }
}
